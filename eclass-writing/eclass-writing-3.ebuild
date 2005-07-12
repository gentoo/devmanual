# Headers.

inherit fnord.eclass

src_compile() {
	do_pre_stuff || die
	fnord_src_compile
	do_post_stuff || die
}
