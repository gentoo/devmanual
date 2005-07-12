# Header.

# Replace any "bye"s which occur at the end of a line with "cheerio!".
sed -i -e 's,bye$,cheerio!,' data.in || die "sed failed"
