# Headers.

pkg_postinst() {
	if has_version '<x11-wm/fluxbox-0.9.10-r3' ; then
		ewarn "You must restart fluxbox before using the [include] /directory/"
		ewarn "feature if you are upgrading from an older fluxbox!"
		ewarn " "
	fi
	einfo "If you experience font problems, or if fluxbox takes a very"
	einfo "long time to start up, please try the 'disablexmb' USE flag."
	einfo "If that fails, please report bugs upstream."
	epause
}
