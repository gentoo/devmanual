#

src_compile() {
	# Our package has optional perl, python and ruby support
	econf \
		$(use_enable perl perlinterp ) \
		$(use_enable python pythoninterp ) \
		$(use_enable ruby rubyinterp ) \
		|| die "Configure failed!"

	# ...
}

src_compile() {
	econf $(use_with X x11 ) || die "econf failed!"
}
