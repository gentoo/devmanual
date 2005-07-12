# Headers.

src_compile() {
	CONFIG="-DLINUX -DGKRELLM2 -fPIC `pkg-config gtk+-2.0 --cflags`"
	LIBS="`pkg-config gtk+-2.0 --libs` -shared"
	OBJS="top_three2.o gkrelltop2.o"

	gcc -c $CONFIG $CFLAGS top_three.c -o top_three2.o || die
	gcc -c $CONFIG $CFLAGS gkrelltop.c -o gkrelltop2.o || die
	gcc $LIBS $CONFIG $CFLAGS -o gkrelltop2.so $OBJS || die
}
