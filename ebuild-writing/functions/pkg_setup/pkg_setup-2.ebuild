# Headers.

pkg_setup() {
	# We need to know which GUI we're building in several
	# different places, so work it out here.
	if use gtk ; then
		if use gtk2 ; then
			export mypkg_gui="gtk2"
		else
			export mypkg_gui="gtk1"
		fi
	elif use motif then
		export mypkg_gui="motif"
	else
		export mypkg_gui="athena"
	fi
}
