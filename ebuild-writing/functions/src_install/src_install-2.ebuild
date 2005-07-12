# Headers.

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"
	dodoc README CHANGES
}
