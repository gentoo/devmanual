#

src_compile() {
	# We have optional perl, python and ruby support
	econf \
		$(use_enable perl ) \
		$(use_enable python ) \
		$(use_enable ruby ) \
		|| die "Configure failed!"

	# ...
}

src_compile() {
	# Our package optional IPv6 support which uses --with rather than
	# --enable / --disable

	econf $(use_with ipv6 ) || die "econf failed!"

	# ...
}
