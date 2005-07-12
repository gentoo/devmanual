# Header.

# replace all instances of "some text" with "different content" in
# somefile.txt
sed -i -e 's/some text/different content/g' somefile.txt || \
	die "Sed broke!"
