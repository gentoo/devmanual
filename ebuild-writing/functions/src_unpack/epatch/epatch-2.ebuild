# Headers.

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${P}-suse-update.patch.bz2
	epatch ${FILESDIR}/${PV}-no-TIOCGDEV.patch
}
