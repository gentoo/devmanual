# Headers.

src_compile() {
	$(tc-getCC ) ${CFLAGS} -o ${PN} ${P}.c \
		|| die "Compile failed!"
}
