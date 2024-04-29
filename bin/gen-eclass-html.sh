#!/bin/bash

# pre1) OOB: The host needs to emerge eclass-manpages on a daily basis.
# This script should be run before the make operation is performed

set -o pipefail

OUTPUTDIR="eclass-reference"

IFS='' read -r -d '' HEADER << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>@TITLE@ &#x2013; Gentoo Development Guide</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="The Gentoo Devmanual is a technical manual which covers topics such as writing ebuilds and eclasses, and policies that developers should be abiding by.">
	<link href="https://assets.gentoo.org/tyrian/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="https://assets.gentoo.org/tyrian/tyrian.min.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" href="../../devmanual.css" type="text/css">
	<link rel="icon" href="https://www.gentoo.org/favicon.ico" type="image/x-icon">
</head>
<body>
<header><div class="site-title"><div class="container"><div class="row">
<div class="site-title-buttons"><div class="btn-group btn-group-sm">
<a href="https://get.gentoo.org/" role="button" class="btn get-gentoo"><span class="fa fa-fw fa-download"></span><strong> Get Gentoo!</strong></a><div class="btn-group btn-group-sm">
<a class="btn gentoo-org-sites dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"><span class="fa fa-fw fa-map-o"></span><span class="hidden-xs"> gentoo.org sites </span><span class="caret"></span></a><ul class="dropdown-menu dropdown-menu-right">
<li><a href="https://www.gentoo.org/" title="Main Gentoo website"><span class="fa fa-home fa-fw"></span> gentoo.org</a></li>
<li><a href="https://wiki.gentoo.org/" title="Find and contribute documentation"><span class="fa fa-file-text-o fa-fw"></span> Wiki</a></li>
<li><a href="https://bugs.gentoo.org/" title="Report issues and find common issues"><span class="fa fa-bug fa-fw"></span> Bugs</a></li>
<li><a href="https://forums.gentoo.org/" title="Discuss with the community"><span class="fa fa-comments-o fa-fw"></span> Forums</a></li>
<li><a href="https://packages.gentoo.org/" title="Find software for your Gentoo"><span class="fa fa-hdd-o fa-fw"></span> Packages</a></li>
<li class="divider"></li>
<li><a href="https://planet.gentoo.org/" title="Find out what's going on in the developer community"><span class="fa fa-rss fa-fw"></span> Planet</a></li>
<li><a href="https://archives.gentoo.org/" title="Read up on past discussions"><span class="fa fa-archive fa-fw"></span> Archives</a></li>
<li><a href="https://sources.gentoo.org/" title="Browse our source code"><span class="fa fa-code fa-fw"></span> Sources</a></li>
<li class="divider"></li>
<li><a href="https://infra-status.gentoo.org/" title="Get updates on the services provided by Gentoo"><span class="fa fa-server fa-fw"></span> Infra Status</a></li>
</ul>
</div>
</div></div>
<div>
<a href="/" title="Back to the homepage" class="site-logo"><object data="https://assets.gentoo.org/tyrian/site-logo.svg" type="image/svg+xml"><img src="https://assets.gentoo.org/tyrian/site-logo.png" alt="Gentoo Linux Logo"></object></a><span class="site-label">Development Guide</span>
</div>
</div></div></div>
<nav class="tyrian-navbar" role="navigation"><div class="container"><div class="row">
<div class="navbar-header"><button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button></div>
<div class="collapse navbar-collapse navbar-main-collapse"><ul class="nav navbar-nav">
<li><a href="../../index.html"><span class="fa fa-home"></span>&nbsp;Home</a></li>
</ul></div>
</div></div></nav>
<div class="container"><div class="row"><div class="col-md010">
<ol class="breadcrumb">
<li><a href="../../index.html">Master index</a></li>
<li><a href="../index.html">Eclass reference</a></li>
</ol>
</div></div></div>
</header>
<main><div class="container">
EOF

IFS='' read -r -d '' FOOTER << 'EOF'
</div></main>
<footer><div class="container">
<div class="row">
<div class="col-xs-12 col-md-offset-2 col-md-7"></div>
<div class="col-xs-12 col-md-3">
<h3 class="footerhead">Questions or comments?</h3>
              Please feel free to <a href="https://www.gentoo.org/inside-gentoo/contact/">contact us</a>.
            </div>
</div>
<div class="row">
<div class="col-xs-2 col-sm-3 col-md-2">
<ul class="footerlinks three-icons">
<li><a href="https://twitter.com/gentoo" title="@Gentoo on Twitter"><span class="fa fa-twitter fa-fw"></span></a></li>
<li><a href="https://www.facebook.com/gentoo.org" title="Gentoo on Facebook"><span class="fa fa-facebook fa-fw"></span></a></li>
</ul>
<div class="text-center">
<a href="https://wiki.gentoo.org/wiki/Foundation:Privacy_Policy">Privacy Policy</a>
</div>
</div>
<div class="col-xs-10 col-sm-9 col-md-10">
<strong>Copyright (C) 2001-2024 Gentoo Authors</strong><br><small>
                Gentoo is a trademark of the Gentoo Foundation, Inc.
                The text of this document is distributed under the
                <a href="https://www.gnu.org/licenses/gpl-2.0.html">GNU General Public License, version 2</a>.
                The <a href="https://www.gentoo.org/inside-gentoo/foundation/name-logo-guidelines.html">Gentoo Name and Logo Usage Guidelines</a> apply.
              </small>
</div>
</div>
</div></footer><script src="https://assets.gentoo.org/tyrian/jquery.min.js"></script><script src="https://assets.gentoo.org/tyrian/bootstrap.min.js"></script>
</body>
</html>
EOF

guesscompress() {
	case "$1" in
		*.gz|*.z)	echo "gunzip -c" ;;
		*.bz2|*.bz)	echo "bunzip2 -c" ;;
		*.lz)		echo "lzip -dc" ;;
		*.lzma)		echo "unlzma -c" ;;
		*.lzo)		echo "lzop -dc" ;;
		*.xz)		echo "xzdec" ;;
		*.zst)		echo "zstd -dc" ;;
		*)		echo "cat" ;;
	esac
}

usage() {
	cat <<- EOF >&2
	Usage: $0 [OPTION]...
	Convert eclass man pages to HTML.

	  -n    do not build anything, only create a placeholder index
	  -h    display this help and exit
	EOF
}

while getopts 'nh' opt; do
	case ${opt} in
		n) NOMAN=true ;;
		h) usage; exit 0 ;;
		*) usage; exit 1 ;;
	esac
done
shift $((OPTIND-1))

MANPAGES=()
[[ -n ${NOMAN} ]] || MANPAGES=(
	$(/usr/bin/qlist -e eclass-manpages)
	# We also need a couple of Portage man pages
	/usr/share/man/man5/ebuild.5*
	/usr/share/man/man5/make.conf.5*
) || exit 1

[[ -d ${OUTPUTDIR} ]] || mkdir -p "${OUTPUTDIR}" || exit 1

for i in "${MANPAGES[@]}"; do
	FILEBASE=${i##*/}
	BASENAME="${FILEBASE%.5*}"
	[[ ${BASENAME} != "${FILEBASE}" ]] || continue
	DIRNAME="${OUTPUTDIR}/${BASENAME}"
	FINAL="${DIRNAME}/index.html"
	DECOMPRESS=$(guesscompress "${i}")
	[[ -d ${DIRNAME} ]] || mkdir -p "${DIRNAME}" || exit 1
	# update the dir's mtime to prevent its removal below
	touch "${DIRNAME}" || exit 1
	# rebuild the man page each time
	echo -n "${HEADER//@TITLE@/${BASENAME}}" > "${FINAL}" || exit 1
	# generate html pages and fix hyperlinks for eclass and other man pages
	${DECOMPRESS} "${i}" | /usr/bin/man2html -r \
	| sed -e '1,/<BODY>/d;/<\/BODY>/,$d' \
		-e '/<A HREF=/s:"\.\./man5/\([^"]*eclass\|ebuild\|make\.conf\)\.5\.html":"../\1/index.html":g' \
		-e 's:<A HREF="\.\./man[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's:<A HREF="[^"]*//localhost/[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's:<A HREF="[^"]*\${[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's,<A HREF="mailto:[^"]*">\([^<>]*\)</A>,\1,g' \
		-e 's:<TT>\([^<>]*\)</TT>:\1:g' \
		-e 's:<DL COMPACT>:<DL>:g' \
		-e 's:<TR VALIGN=top>:<TR>:g' \
		-e '/<A NAME/{N;s:<A NAME=\(.*\)>.*</A>\(.*<H[1-6]\)>:\2 ID=\1>:}' \
		>> "${FINAL}" || exit 1
	echo -n "${FOOTER}" >> "${FINAL}" || exit 1
done

# Remove old dirs (eclasses that were dropped from the tree)
find "${OUTPUTDIR}" -mindepth 1 -maxdepth 1 -mtime +1 -exec rm -R {} \;

# build the index, rebuilding it each time
cat << 'EOF' > "${OUTPUTDIR}"/text.xml || exit 1
<?xml version="1.0" encoding="UTF-8"?>
<guide self="eclass-reference/">
<chapter>
<title>Eclass reference</title>
<body>

<p>
This section provides a reference for some of the more commonly used eclasses.
Note that most eclasses have an accompanying manual page. These man pages can be
installed by emerging <c>app-doc/eclass-manpages</c>.
</p>

</body>

<section>
<title>Contents</title>
<body>
EOF

if [[ -n ${NOMAN} ]]; then
	cat <<- 'EOF' >> "${OUTPUTDIR}"/text.xml || exit 1
	<warning>
	This is only a placeholder. If you see this text in the output document,
	then the eclass documentation is missing.
	</warning>
	EOF
else
	echo '<ul class="list-group">' >> "${OUTPUTDIR}"/text.xml || exit 1
	for i in $(find "${OUTPUTDIR}" -maxdepth 1 -mindepth 1 -type d | sort); do
		echo "<li><uri link=\"$(basename $i)/index.html\">$(basename $i)</uri></li>" >> "${OUTPUTDIR}"/text.xml || exit 1
	done
	echo '</ul>' >> "${OUTPUTDIR}"/text.xml || exit 1
fi

cat << 'EOF' >> "${OUTPUTDIR}"/text.xml || exit 1
</body>
</section>
</chapter>
</guide>
EOF
