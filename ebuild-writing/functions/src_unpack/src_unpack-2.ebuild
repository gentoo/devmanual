# Headers.

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}/${P}-fix-bogosity.patch
	use pam && epatch ${FILESDIR}/${PV}/${P}-pam.patch

	sed -i -e 's/"ispell"/"aspell"/' src/defaults.h || die "Sed failed!"
}
