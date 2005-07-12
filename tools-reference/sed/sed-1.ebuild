# Header.

# This plugin is mapped to the 'h' key by default, which conflicts with some
# other mappings. Change it to use 'H' instead.
sed -i 's/\(noremap <buffer> \)h/\1H/' info.vim \
	|| die 'sed failed'
