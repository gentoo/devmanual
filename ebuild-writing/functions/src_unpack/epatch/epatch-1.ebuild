# Headers.

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-destdir.patch
	epatch ${FILESDIR}/${P}-parallel_build.patch
}
