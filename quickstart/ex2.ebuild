# Example

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~hppa mips sparc x86"
IUSE=""

DEPEND="dev-libs/popt
	sys-devel/flex
	sys-devel/bison"
RDEPEND="dev-libs/popt"

src_compile() {
	econf --with-popt || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}
