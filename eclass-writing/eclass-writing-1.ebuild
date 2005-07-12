# Headers.

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Ciaran McCreesh <ciaranm@gentoo.org>
# Purpose: install macos .app files to the relevant location.
#
# Bugs to osx@gentoo.org
#

ECLASS="macos-app"
INHERITED="$INHERITED $ECLASS"

# domacosapp: install a macos .app file. Usage is 'domacosapp file' or
# 'domacosapp file newfile'.

domacosapp() {
	[[ -z "${1}" ]] && die "usage: domacosapp <file> <new file>"
	if useq ppc-macos ; then
		insinto /Applications
		newins "$1" "${2:-${1}}" || die "Failed to install ${1}"
	fi
}
