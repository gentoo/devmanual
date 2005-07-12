# Header.

# This plugin uses an 'automatic HelpExtractor' variant. This causes
# problems for us during the unmerge. Fortunately, sed can fix this
# for us. First, we extract the documentation:
sed -e '1,/^" HelpExtractorDoc:$/d' \
	${S}/plugin/ZoomWin.vim > ${S}/doc/ZoomWin.txt \
	|| die "help extraction failed"
# Then we remove the help extraction code from the plugin file:
sed -i -e '/^" HelpExtractor:$/,$d' ${S}/plugin/ZoomWin.vim \
	|| die "help extract remove failed"
