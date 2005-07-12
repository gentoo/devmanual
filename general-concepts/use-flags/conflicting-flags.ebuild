# Header

src_compile() {
	local myconf

	if use ssl && use gnutls ; then
		myconf="${myconf} --enable-ssl --with-ssl=gnutls"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --enable-ssl --with-ssl=openssl"
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf \
		# Other stuff
		${myconf} \
		|| die "configure failed

	emake || die "make failed"
}
