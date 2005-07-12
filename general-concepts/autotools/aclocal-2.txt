# vim: set ft=ebuild

einfo "Regenerating autotools files..."
WANT_AUTOCONF="2.5" aclocal -I ${WORKDIR}/gentoo-m4 || die "aclocal failed"
WANT_AUTOCONF="2.5" autoconf || die "autoconf failed"
