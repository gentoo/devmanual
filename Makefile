# Run a single "find" pass to get a list of all files (with the .git
# directory excluded), then filter out what we need.
ALL_FILES := $(shell find . -name .git -prune -o -type f -print)
XMLS := $(filter %/text.xml,$(ALL_FILES))
SVGS := $(filter %.svg,$(ALL_FILES))
HTMLS := $(subst text.xml,index.html,$(XMLS))
ECLASS_HTMLS := $(filter ./eclass-reference/%/index.html,$(ALL_FILES))
IMAGES := $(patsubst %.svg,%.png,$(SVGS))

# Nonzero value disables external assets for offline browsing.
OFFLINE = 0

all: prereq validate build documents.js

prereq:
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

build: $(HTMLS) $(IMAGES)

# We need to parse all the XMLs every time, not just the ones
# that are newer than the target. This is because each search
# document in devmanual gets a unique ID, which is used to
# quickly tie search matches to the corresponding documents.
documents.js: bin/build_search_documents.py $(XMLS)
	./bin/build_search_documents.py $(XMLS) > _documents.js
	mv _documents.js documents.js

%.png : %.svg
	rsvg-convert --output=$@ $<

# Secondary expansion allows us to use the automatic variable $@ in
# the prerequisites. When it is used (and we have no idea when that
# is, so we assume always) our <include href="foo"> tag induces a
# dependency on the output of all subdirectories of the current
# directories. This wacky rule finds all of those subdirectories by
# looking for text.xml in them, and then replaces "text.xml" in the
# path with "index.html".
#
# We use the pattern %.html rather than the more-sensible %index.html
# because the latter doesn't match our top-level index.html target.
#
.SECONDEXPANSION:
%.html: $$(dir $$@)text.xml devbook.xsl xsl/*.xsl $$(subst text.xml,index.html,$$(wildcard $$(dir $$@)*/text.xml))
	xsltproc --param offline "$(OFFLINE)" devbook.xsl $< > $@

validate:
	@xmllint --noout --dtdvalid devbook.dtd $(XMLS) \
	  && echo "xmllint validation successful"

# Run app-text/tidy-html5 on the output to detect mistakes.
# We have to loop through them because otherwise tidy won't
# tell you which file contains a mistake.
tidy: $(HTMLS) $(ECLASS_HTMLS)
	@status=0; \
	for f in $^; do \
	  output=$$(tidy -q -errors --drop-empty-elements no $${f} 2>&1) \
	  || { status=$$?; echo "Failed on $${f}:"; echo "$${output}"; }; \
	done; \
	test $${status} -eq 0 && echo "tidy validation successful"; \
	exit $${status}

# Delete any orphaned html and image files that could be left over
# after the corresponding source file was moved or removed.
delete-old:
	@-rm -f $(filter-out $(HTMLS) $(ECLASS_HTMLS) $(IMAGES), \
	  $(filter %/index.html %.png,$(ALL_FILES)))
	@find . ! -path './.git*' -type d -empty -delete

clean:
	@rm -f $(HTMLS) $(IMAGES) _documents.js documents.js

.PHONY: all prereq validate build tidy delete-old clean
