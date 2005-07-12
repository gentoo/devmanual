#

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove problematic LDFLAGS declaration
	sed -i -e '/^LDFLAGS/d' src/Makefile.am

	# Rerun autotools
	einfo "Regenerating autotools files..."
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	WANT_AUTOMAKE=1.9 automake || die "automake failed"
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}
