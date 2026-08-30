ECLASSDIR = /var/db/repos/gentoo/eclass
MAN5DIR = /usr/share/man/man5

ECLASSES := $(wildcard $(ECLASSDIR)/*.eclass)
ECLASS_BASENAMES := $(notdir $(ECLASSES))
ECLASS_XMLS := $(addsuffix /text.xml,$(ECLASS_BASENAMES))

MANPAGES := $(wildcard $(MAN5DIR)/ebuild.5* $(MAN5DIR)/make.conf.5*)
# Remove one suffix first (which may be .5 for an uncompressed page,
# or a compression suffix), then remove any remaining .5 suffix
MAN_BASENAMES := $(patsubst %.5,%,$(basename $(notdir $(MANPAGES))))
MAN_HTMLS := $(addsuffix /index.html,$(MAN_BASENAMES))

BASENAMES := $(sort $(ECLASS_BASENAMES) $(MAN_BASENAMES))

export OFFLINE ?= 0

all: clean .WAIT $(ECLASS_XMLS) $(MAN_HTMLS) toc

$(ECLASS_XMLS) &: $(ECLASSES)
	pmaint eclass -f devbook -o "{eclass}.eclass/text.xml" $^

$(MAN_HTMLS) &: $(MANPAGES) toc
	./man-to-html.sh $(MANPAGES)

toc: text.xml.in
	prefix='\
	  <li><uri link="::eclass-reference/'; \
	suffix='/"/></li>'; \
	for i in $(BASENAMES); do \
	  index="$${index}$${prefix}$${i}$${suffix}"; \
	done; \
	sed "/@TOC@/c$${index}" $< > text.xml

text.xml: dummy.xml.in
	cp $< $@

clean:
	@find -mindepth 2 -type f \( -name "*.xml" -o -name "*.html" \) -delete
	@find -type d -empty -delete

distclean: clean
	@rm -f text.xml index.html

.PHONY: all toc clean distclean
.DELETE_ON_ERROR:
