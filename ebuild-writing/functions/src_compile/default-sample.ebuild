#

src_compile() {
	if [ -x ./configure ]; then
		econf
	fi
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake || die "emake failed"
	fi
}
