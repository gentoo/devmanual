# Headers.

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator rpm

MY_PV=$(replace_version_separator 3 '-')
MY_P=fetchmail-${MY_PV}

SRC_URI="http://suse.osuosl.org/suse/i386/9.2/suse/src/${MY_P}.src.rpm"
DESCRIPTION="SuSE 9.2 Fetchmail Source Package"
HOMEPAGE="http://www.suse.com"
LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RESTRICT="nomirror"

# Need to test if the file can be unpacked with rpmoffset and cpio
# If it can't then set:

#DEPEND="app-arch/rpm"

# To force the use of rpmoffset and cpio instead of rpm2cpio from
# app-arch/rpm, then set the following:

#USE_RPMOFFSET_ONLY=1

S=${WORKDIR}/fetchmail-$(get_version_component_range 1-3)

src_unpack () {
	rpm_src_unpack ${A}
	cd ${S}
	EPATCH_SOURCE="${WORKDIR}" EPATCH_SUFFIX="patch" \
		EPATCH_FORCE="yes" epatch
}
