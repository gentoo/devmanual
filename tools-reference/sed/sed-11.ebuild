# Header.

# Add 'Bob' after the 'To:' line:
sed -i -e '/^To: $/a    Bob' data.in || die "Oops"

# Add 'From: Alice' before the 'To:' line:
sed -i -e '/^To: $/i    From: Alice'

# Note that the spacing between the 'i' or 'a' and 'Bob' or 'From: Alice' is simply ignored'

# Add 'From: Alice' indented by two spaces: (You only need to escape the first space)
sed -i -e '/^To: $/i\  From: Alice'
