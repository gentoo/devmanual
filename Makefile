# These "find" commands match text.xml and *.svg files, respectively,
# but only after excluding the .git directory from the search for
# performance and overall sanity reasons.
XMLS := $(shell find . -name .git -prune -o -type f -name 'text.xml' -print)
SVGS := $(shell find . -name .git -prune -o -type f -name '*.svg' -print)
HTMLS := $(subst text.xml,index.html,$(XMLS))
IMAGES := $(patsubst %.svg,%.png,$(SVGS))

all: prereq validate $(HTMLS) $(IMAGES)

prereq:
	@type convert >/dev/null 2>&1 || \
	{ echo "media-gfx/imagemagick[corefonts,svg,truetype] required" >&2;\
          exit 1; }
	@type xsltproc >/dev/null 2>&1 || \
	{ echo "dev-libs/libxslt is required" >&2;\
	  exit 1; }
	@type xmllint >/dev/null 2>&1 || \
	{ echo "dev-libs/libxml2 is required" >&2;\
	  exit 1; }

index:
	@./search_index.py text.xml > documents.js

%.png : %.svg
	convert $< $@

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
	xsltproc devbook.xsl $< > $@

validate: prereq
	@xmllint --noout --dtdvalid devbook.dtd $(XMLS) \
	  && echo "xmllint validation successful"

clean:
	rm -f $(HTMLS) $(IMAGES) documents.js

.PHONY: all prereq validate clean
