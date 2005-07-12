# header

DEPEND="gtk? (
			gtk2? ( >=x11-libs/gtk+-2.4 )
			!gtk2? ( =x11-libs/gtk+-1.2* ) )
		!gtk? ( sys-libs/ncurses )"
