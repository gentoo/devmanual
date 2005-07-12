# header

	# USE conditional blocks...
	if use livecd ; then
		# remove some extra files for a small livecd install
		rm -fr ${vimfiles}/{compiler,doc,ftplugin,indent}
	fi

	# Inverse USE conditional blocks...
	if ! use cscope ; then
		# the --disable-cscope configure arg doesn't quite work properly,
		# so sed it out of feature.h if we're not USEing cscope.
		sed -i -e '/# define FEAT_CSCOPE/d' src/feature.h || die "couldn't disable cscope"
	fi

	# USE conditional statements...
	use ssl && epatch ${FILESDIR}/${P}-ssl.patch
	use sparc && filter-flags -fomit-frame-pointer

	# Inverse USE conditional statements...
	use ncurses || epatch ${FILESDIR}/${P}-no-ncurses.patch
