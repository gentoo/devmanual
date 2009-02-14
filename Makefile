text_files := $(shell find -name "text.xml" | sed -e "s/text.xml$$/index.html/")
image_files := $(shell find -name "*.svg" | sed -e "s/svg$$/png/")

all: $(text_files) $(image_files)

%index.html : %text.xml
	xsltproc devbook.xsl $< > $@ 

# Someone should figure out a way to put this to the pattern
index.html : text.xml
	xsltproc devbook.xsl $< > $@ 

%.png : %.svg
	convert $< $@

clean:
	@find . -name "*.png" -a \! -path "./icons/*" -exec rm -v {} +
	@find . -name "index.html" -exec rm -v {} +

