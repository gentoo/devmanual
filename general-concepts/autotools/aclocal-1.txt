# vim: set ft=ebuild

einfo "Regenerating autotools files..."
cp ${WORKDIR}/gentoo-m4 ${S}/m4 || die "m4 copy failed"
WANT_AUTOCONF="2.5" aclocal -I ${S}/m4 || die "aclocal failed"
WANT_AUTOCONF="2.5" autoconf || die "autoconf failed"
