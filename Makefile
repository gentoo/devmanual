all: transform

clean:
	@find -name "index.html" | xargs rm
	@find -name "*.png" | xargs rm

transform:
	@for file in $$(find -name text.xml) ; do \
		htmlfile=$${file/text.xml/index.html} ; \
		echo "Processing $${file} --> $${htmlfile}" ; \
		xsltproc devbook.xsl $$file > $$htmlfile ; \
	done
	@for file in $$(find -name *.svg) ; do \
		pngfile=$${file/.svg/.png} ; \
		echo "Converting $${file} --> $${pngfile}" ; \
		convert $$file $$pngfile ; \
	done
