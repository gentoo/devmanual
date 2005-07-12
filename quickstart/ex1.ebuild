# Example

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Exuberant ctags generates tags files for quick source navigation"
HOMEPAGE="http://ctags.sourceforge.net"
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~sparc ~x86"
IUSE=""

src_compile() {
	econf --with-posix-regex || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc FAQ NEWS README
	dohtml EXTENDING.html ctags.html
}
