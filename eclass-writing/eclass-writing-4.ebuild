# Headers.

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Original Author: Ciaran McCreesh <ciaranm@gentoo.org>
# Purpose: Demonstration of EXPORT_FUNCTIONS. Defines simple wrappers for the
# (hypothetical) 'jmake' build system and a default src_compile.

ECLASS="jmake"
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_compile

DEPEND=">=sys-devel/jmake-2"

jmake-configure() {
	jmake configure --prefix=/usr "$@"
}

jmake-build() {
	jmake dep && jmake build "$@"
}

jmake_src_compile() {
	jmake-configure || die "configure failed"
	jmake-build || die "build failed"
}
