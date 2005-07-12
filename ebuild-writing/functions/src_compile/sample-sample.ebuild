#

src_compile() {
	use sparc && filter-flags -fomit-frame-pointer
	append-ldflags -Wl,-z,now

	econf \
		$(use_enable ssl ) \
		$(use_enable perl perlinterp ) \
		|| die "Configure failed!"

	emake || die "Make failed!"
}
