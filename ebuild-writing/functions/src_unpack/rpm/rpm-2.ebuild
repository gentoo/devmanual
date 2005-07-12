# Headers.

src_unpack () {
	rpm_src_unpack ${A}
	cd ${S}

	use ssl && epatch ${FILESDIR}/${PV}/${P}-ssl.patch
}
