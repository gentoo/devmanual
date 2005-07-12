# Header

pkg_setup() {
	# Unset all locale related variables, they can make the
	# build fail.

	eval unset ${!LC_*} LANG
}
