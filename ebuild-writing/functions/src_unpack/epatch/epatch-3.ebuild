# Headers.

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SOURCE="${WORKDIR}/patches" EPATCH_SUFFIX="patch" \
		EPATCH_FORCE="yes" epatch
}
