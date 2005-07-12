# Header.

# Replace any lines which are exactly "change this line" with "have a
# cookie".
sed -i -e 's-^change this line$-have a cookie-' data.in || die "Oops"
