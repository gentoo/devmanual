all: transform

clean:
	@find -name "index.html" | xargs rm

transform:
	@for file in $$(find -name text.xml) ; do \
		htmlfile=$${file/text.xml/index.html} ; \
		echo "Processing $${file} --> $${htmlfile}" ; \
		xsltproc devbook.xsl $$file > $$htmlfile ; \
	done
