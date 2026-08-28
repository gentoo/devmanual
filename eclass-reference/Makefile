MAN5DIR = /usr/share/man/man5

ECLASS_MANPAGES := $(foreach f,$(shell /usr/bin/qlist -e eclass-manpages) \
	,$(and $(findstring /man5/,$(f)),$(f)))
EXTRA_MANPAGES := $(wildcard $(MAN5DIR)/ebuild.5* $(MAN5DIR)/make.conf.5*)
MANPAGES := $(sort $(ECLASS_MANPAGES) $(EXTRA_MANPAGES))

# Remove one suffix first (which may be .5 for an uncompressed page,
# or a compression suffix), then remove any remaining .5 suffix
BASENAMES := $(patsubst %.5,%,$(basename $(notdir $(MANPAGES))))
MAN_HTMLS := $(addsuffix /index.html,$(BASENAMES))

export OFFLINE ?= 0

all: clean .WAIT $(MAN_HTMLS) toc

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
	@find -mindepth 2 -type f -name "*.html" -delete
	@find -type d -empty -delete

distclean: clean
	@rm -f text.xml index.html

.PHONY: all toc clean distclean
.DELETE_ON_ERROR:
