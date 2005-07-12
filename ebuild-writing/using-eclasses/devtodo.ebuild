# Header

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils bash-completion flag-o-matic

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc s390 sparc x86 ppc64"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"
	replace-flags -O? -O1
	econf --sysconfdir=/etc/devtodo || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog QuickStart README TODO doc/scripts.sh \
	doc/scripts.tcsh doc/todorc.example contrib/tdrec || die "dodoc failed"
	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	echo
	einfo "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	einfo "and manual page have been removed."
	bash-completion_pkg_postinst
}

