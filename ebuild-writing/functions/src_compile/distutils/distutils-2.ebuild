# Headers.

src_compile() {
	distutils_src_compile
	# ...
}

src_install() {
	# From the docutils ebuild
	distutils_src_install
	cd ${S}/tools
	for tool in *.py; do
		newbin ${tool} docutils-${tool}
	done

	# ...
}
