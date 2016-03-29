ALL_DIRS := $(shell find -name "text.xml" -exec dirname {} +)
text_files := $(addsuffix /index.html,$(ALL_DIRS))
image_files := $(shell find -name "*.svg" | sed -e "s/svg$$/png/")

all: prereq $(text_files) $(image_files)

prereq:
	@type -p convert &>/dev/null || { echo "media-gfx/imagemagick with corefonts, svg and truetype required" >&2; exit 1; }; \
		type -p xsltproc &>/dev/null || { echo "dev-libs/libxslt is required" >&2; exit 1; }

%.png : %.svg
	convert $< $@

clean:
	@find . -name "*.png" -a \! -path "./icons/*" -exec rm -v {} +
	@find . -name "index.html" -exec rm -v {} +

# Given a directory with text.xml in it, return its immediate children as prerequisites
# Hypothetical example:
# INPUT:  "./archs" "./archs/amd64 ./archs/x86 ./ebuild-writing ./appendices"
# OUTPUT: ./archs/amd64/index.html ./archs/amd64/index.html
define get_prerequisites =
$(addsuffix /index.html,$(foreach subdir,$(2),$(if $(subst $(1)/,,$(dir $(subdir))),,$(subdir))))
endef

# Given a directory with text.xml in it, genereate a complete build rule with prerequisites
# Hypothetical example:
# INPUT:  "./archs" "./archs/amd64 ./archs/x86 ./ebuild-writing ./appendices"
# OUTPUT  ./archs/index.html: ./archs/text.xml devbook.xsl ./archs/amd64/index.html ./archs/x86/index.html
#                 xsltproc devbook.xsl ./archs/text.xml > ./archs/index.html
define generate_rule =
$(1)/index.html: $(1)/text.xml devbook.xsl $(call get_prerequisites,$(1),$(2))
	xsltproc devbook.xsl $$< > $$@
endef

# This generates individual build rules for all the text files by
# iterating over all the directories in the file system tree
$(foreach dir,$(ALL_DIRS),$(eval $(call generate_rule,$(dir),$(filter-out $(dir),$(ALL_DIRS)))))

.PHONY: all prereq clean
