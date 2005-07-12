# HEADER

# DO NOT DO THIS!
if ! has_version "x11-libs/gtk+" ; then
	DEPEND="${DEPEND}
			gtk2?  ( >=x11-libs/gtk+-2 )
			!gtk2? ( =x11-libs/gtk+-1.2* )"
fi
