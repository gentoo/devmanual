# Headers.

pkg_preinst() {
	enewgroup foo
	enewuser foo -1 /bin/false /dev/null foo
}
