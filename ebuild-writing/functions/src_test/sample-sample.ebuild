#

src_test() {
	cd ${S}/src/testdir

	# Test 49 won't work inside a portage environment
	sed -i -e 's~test49.out~~g' Makefile

	# Try to run the non-gui tests only
	make test-nongui \
			|| die "At least one test failed"
}
