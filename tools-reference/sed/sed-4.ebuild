# Header.

sed [ option flags ] \
	-e 'first command' \
	-e 'second command' \
	-e 'and so on' \
	input-file > output-file \
	|| die "Oops, sed didn't work!"
