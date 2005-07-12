# Header.

# Replace any "hello"s which occur at the start of a line with "howdy".
sed -i -e 's!^hello!howdy!' data.in || die "sed failed"
