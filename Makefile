GENTOO_REPO ?= /var/db/repos/gentoo

# Run a single "find" pass to get a list of all files (with the .git
# directory excluded), then filter out what we need.
ALL_FILES := $(shell find . -name .git -prune -o -type f -print)
XMLS := $(filter-out ./eclass-reference/%/text.xml,$(filter %/text.xml,$(ALL_FILES)))
SVGS := $(filter %.svg,$(ALL_FILES))
HTMLS := $(subst text.xml,index.html,$(XMLS))
ALL_ECLASSES := $(shell find $(GENTOO_REPO)/eclass/*.eclass -type f -print)
ECLASS_XMLS := $(patsubst $(GENTOO_REPO)/eclass/%,./eclass-reference/%/text.xml,$(ALL_ECLASSES))
ECLASS_HTMLS := $(subst text.xml,index.html,$(ECLASS_XMLS))
IMAGES := $(patsubst %.svg,%.png,$(SVGS))

CSS_FILES = devmanual.css offline.css
JS_FILES = search.js documents.js

prefix = /usr/local/share
docdir = $(prefix)/doc/devmanual
htmldir = $(docdir)
DESTDIR =

# Nonzero value disables external assets for offline browsing.
OFFLINE = 0

all: prereq validate build documents.js

prereq:
	@type pmaint >/dev/null 2>&1 || \
	{ echo "sys-apps/pkgcore required" >&2;\
	  exit 1; }
	@type rsvg-convert >/dev/null 2>&1 || \
	{ echo "gnome-base/librsvg required" >&2;\
	  exit 1; }
	@type xsltproc >/dev/null 2>&1 || \
	{ echo "dev-libs/libxslt is with python required" >&2;\
	  exit 1; }
	@type xmllint >/dev/null 2>&1 || \
	{ echo "dev-libs/libxml2 is required" >&2;\
	  exit 1; }
	@fc-list -q "Open Sans" || \
	{ echo "media-fonts/open-sans is required" >&2;\
	  exit 1; }

build: $(HTMLS) $(ECLASS_HTMLS) eclass-reference/index.html $(IMAGES)

# We need to parse all the XMLs every time, not just the ones
# that are newer than the target. This is because each search
# document in devmanual gets a unique ID, which is used to
# quickly tie search matches to the corresponding documents.
documents.js: bin/build_search_documents.py $(XMLS)
	@python3 bin/build_search_documents.py $(XMLS) > $@ && echo "$@ built"

%.svg : %.dot
	dot -T svg -o $@ $<

%.png : %.svg
	rsvg-convert --output=$@ $<

# Secondary expansion allows us to use the automatic variable $@ in
# the prerequisites.
#
# We use the pattern %.html rather than the more-sensible %index.html
# because the latter doesn't match our top-level index.html target.
#
.SECONDEXPANSION:
%.html: $$(dir $$@)text.xml devbook.xsl xsl/*.xsl
	xsltproc --param offline "$(OFFLINE)" devbook.xsl $< > $@

eclass-reference/text.xml: $(ECLASS_XMLS) bin/gen-eclass-html.sh
	bin/gen-eclass-html.sh

$(ECLASS_XMLS) &: $(ALL_ECLASSES)
	pmaint eclass -f devbook -o "eclass-reference/{eclass}.eclass/text.xml" $^

appendices/todo-list/index.html: $(XMLS)

# Each HTML file must depend on its XML file with all its descendants
# (for the contents tree), all its ancestors (for breadcrumbs), and
# the previous and next documents (for backward and forward links).
# Generate the list of dependencies with XSLT, which appears to be a
# better tool for this than make.
.depend: $(XMLS) eclass-reference/text.xml depend.xsl devbook.xsl
	@xsltproc depend.xsl $(XMLS) | sed ':x;s%[^ /]*/\.\./%%;tx' > $@

install: all
	set -e; \
	for file in $(HTMLS) $(ECLASS_HTMLS) $(IMAGES); do \
	  install -d "$(DESTDIR)$(htmldir)"/$${file%/*}; \
	  install -m 644 $${file} "$(DESTDIR)$(htmldir)"/$${file}; \
	done
	install -m 644 $(CSS_FILES) "$(DESTDIR)$(htmldir)"/
	if test $(OFFLINE) -eq 0; then \
	  install -m 644 $(JS_FILES) "$(DESTDIR)$(htmldir)"/; \
	fi

# Not all versions of xmllint support --quiet, so test for it first
validate: devbook.rng $(ECLASS_XMLS)
	@opt=--quiet; xmllint --help 2>&1 | grep -q -- --quiet || opt=; \
	xmllint --noout $${opt} --relaxng $< $(XMLS)
	@echo "xmllint validation successful"

%.rng: %.rnc
	trang $< $@
	sed -i -e '2s/^/<!-- Auto-generated from $<; do not edit! -->\n/' $@

# Run app-text/htmltidy on the output to detect mistakes.
# We have to loop through them because otherwise tidy won't
# tell you which file contains a mistake.
tidy: $(HTMLS) $(ECLASS_HTMLS)
	@status=0; \
	for f in $^; do \
	  output=$$(sed 's/href=""/href="index.html"/' $${f} \
	    | tidy -q -errors --drop-empty-elements no 2>&1) \
	  || { status=$$?; echo "Failed on $${f}:"; echo "$${output}"; }; \
	done; \
	exit $${status}
	@echo "tidy validation successful"

check: validate tidy

dist:
	COMMITDATE=$$(TZ=UTC git log -1 --pretty="format:%cd" \
	  --date="format-local:%Y%m%d"); \
	TARBALL="devmanual-0_pre$${COMMITDATE}.tar.xz"; \
	echo "Creating tarball: $${TARBALL}"; \
	git archive --format=tar --prefix=devmanual/ HEAD | xz > $${TARBALL}

clean:
	@rm -f $(HTMLS) $(IMAGES) $(ECLASS_HTMLS) $(ECLASS_XMLS) documents.js .depend

.PHONY: all prereq build install check validate tidy dist clean

-include .depend
