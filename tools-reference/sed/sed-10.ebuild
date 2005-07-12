# Header.

# Replace any "emacs" instances (ignoring case) with "Vim"
sed -i -e 's/emacs/Vim/gi' editors.txt || die "Ouch"
