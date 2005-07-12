#

	# -fomit-frame-pointer leads to nasty broken code on sparc thanks to a
	# rather icky asm function
	use sparc && filter-flags -fomit-frame-pointer
