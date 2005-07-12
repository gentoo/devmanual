# Header

inherit versionator

if [[ $(get_major_version ) -ge 7 ]] ; then
	IUSE="${IUSE} tcltk mzscheme"
	DEPEND="$DEPEND
		tcltk?	  ( dev-lang/tcl )
		mzscheme? ( dev-lisp/mzscheme )"
	RDEPEND="$RDEPEND
		tcltk?	  ( dev-lang/tcl )
		mzscheme? ( dev-lisp/mzscheme )"

	if [[ "${MY_PN}" != "vim-core" ]] ; then
		RDEPEND="${RDEPEND} !<app-vim/align-30-r1"
	fi
fi
