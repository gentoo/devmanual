# Headers

pkg_prerm() {
	# clean up temp files
	[[ -d "${ROOT}/var/tmp/foo" ]] && rm -rf "${ROOT}/var/tmp/foo"
}
