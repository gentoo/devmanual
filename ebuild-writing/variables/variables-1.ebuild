# Headers

SRC_URI="http://example.com/files/${P}-core.tar.bz2
	x86?   ( http://example.com/files/${P}/${P}-sse-asm.tar.bz2 )
	ppc?   ( http://example.com/files/${P}/${P}-vmx-asm.tar.bz2 )
	sparc? ( http://example.com/files/${P}/${P}-vis-asm.tar.bz2 )
	doc?   ( http://example.com/files/${P}/${P}-docs.tar.bz2 )"
