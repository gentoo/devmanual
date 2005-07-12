# Headers.

ECLASS="fnord"
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_compile

fnord_src_compile() {
	do_stuff || die
}
