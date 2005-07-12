# Header.

ebegin "Creating a menu file (may take a while)"
mkdir -p "${T}/home/.fluxbox" || die "mkdir home failed"
MENUFILENAME="${S}/data/menu" MENUTITLE="Fluxbox ${PV}" \
	CHECKINIT="no. go away." HOME="${T}/home" \
	${S}/util/fluxbox-generate_menu -is -ds \
	|| die "menu generation failed"
eend $?
