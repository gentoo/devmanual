# Header.

inherit multilib

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
