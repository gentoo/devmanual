# Header.

# replace all instances of "/usr/local" with "/usr"
sed -i -e 's~/usr/local~/usr~g' somefile.txt || \
	die "sed broke"
