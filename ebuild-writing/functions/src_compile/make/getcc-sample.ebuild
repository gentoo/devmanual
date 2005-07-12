#

inherit flag-o-matic toolchain-funcs

src_compile() {
	# -Os not happy
	replace-flags -Os -O2

	# We have a weird build.sh to work with which ignores our
	# compiler preferences. yay!
	sed -i -e "s:cc -O2:$(tc-getCC) ${CFLAGS}:" build.sh \
		|| die "sed Fix failed. Uh-oh..."
	./build.sh || die "Build failed!"
}
