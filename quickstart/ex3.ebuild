# Header

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="GNU charset conversion library for libc which doesn't implement it"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND="virtual/libc
	!sys-libs/glibc"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

