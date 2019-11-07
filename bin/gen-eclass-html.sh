#!/bin/bash

# pre1) OOB: The host needs to emerge eclass-manpages on a daily basis.
# This script should be run before the make operation is performed

OUTPUTDIR="eclass-reference"

IFS='' read -r -d '' FOOTER << 'EOF'
</div>
<footer><div class="container">
<div class="row">
<div class="col-xs-12 col-md-offset-2 col-md-7"></div>
<div class="col-xs-12 col-md-3">
<h3 class="footerhead">Questions or comments?</h3>
              Please feel free to <a href="https://www.gentoo.org/inside-gentoo/contact/">contact us</a>.
            </div>
</div>
<div class="row">
<div class="col-xs-2 col-sm-3 col-md-2"><ul class="footerlinks three-icons">
<li><a href="http://twitter.com/gentoo" title="@Gentoo on Twitter"><span class="fa fa-twitter fa-fw"></span></a></li>
<li><a href="https://www.facebook.com/gentoo.org" title="Gentoo on Facebook"><span class="fa fa-facebook fa-fw"></span></a></li>
<li></li>
</ul></div>
<div class="col-xs-10 col-sm-9 col-md-10">
<strong>Copyright (C) 2001-2019 Gentoo Authors</strong><br><small>
                Gentoo is a trademark of the Gentoo Foundation, Inc.
                The text of this document is distributed under the
                <a href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
                The <a href="https://www.gentoo.org/inside-gentoo/foundation/name-logo-guidelines.html">Gentoo Name and Logo Usage Guidelines</a> apply.
              </small>
</div>
</div>
</div></footer><script src="https://assets.gentoo.org/tyrian/jquery.min.js"></script><script src="https://assets.gentoo.org/tyrian/bootstrap.min.js"></script>
</body>
</html>
EOF

# We also need the ebuild man page
for i in $(/usr/bin/qlist eclass-manpages) /usr/share/man/man5/ebuild.5.bz2; do
	BASENAME="$(basename $i .5.bz2)"
	[[ ${BASENAME} != "${i##*/}" ]] || continue
	DIRNAME="${OUTPUTDIR}/${BASENAME}"
	TMP="${DIRNAME}/index.html.tmp"
	FINAL="${DIRNAME}/index.html"
	[[ -d ${DIRNAME} ]] || mkdir -p ${DIRNAME}
	# rebuild the man page each time
	cat << EOF > ${FINAL}
<!DOCTYPE html><html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>$BASENAME - Gentoo Development Guide</title>
	<link rel="stylesheet" href="../../devmanual.css" type="text/css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="The Gentoo Devmanual is a technical manual which covers topics such as writing ebuilds and eclasses, and policies that developers should be abiding by.">
	<link href="https://assets.gentoo.org/tyrian/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="https://assets.gentoo.org/tyrian/tyrian.min.css" rel="stylesheet" media="screen">
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
<li class="divider">
<li><a href="https://planet.gentoo.org/" title="Find out what's going on in the developer community"><span class="fa fa-rss fa-fw"></span> Planet</a></li>
<li><a href="https://archives.gentoo.org/" title="Read up on past discussions"><span class="fa fa-archive fa-fw"></span> Archives</a></li>
<li><a href="https://sources.gentoo.org/" title="Browse our source code"><span class="fa fa-code fa-fw"></span> Sources</a></li>
<li class="divider">
<li><a href="https://infra-status.gentoo.org/" title="Get updates on the services provided by Gentoo"><span class="fa fa-server fa-fw"></span> Infra Status</a></li>
</ul>
</div>
</div></div>
<div class="logo">
<a href="/" title="Back to the homepage" class="site-logo"><object data="https://assets.gentoo.org/tyrian/site-logo.svg" type="image/svg+xml"><img src="https://assets.gentoo.org/tyrian/site-logo.png" alt="Gentoo Linux Logo"></object></a><span class="site-label">Development Guide</span>
</div>
</div></div></div>
<nav class="tyrian-navbar" role="navigation"><div class="container"><div class="row">
<div class="navbar-header"><button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button></div>
<div class="collapse navbar-collapse navbar-main-collapse"><ul class="nav navbar-nav">
<li><a href="/index.html"><i class="fa fa-home"></i>  Home</a></li>
<li><a href="../index.html"><i class="fa fa-arrow-up"></i>  Eclass Reference</a></li>
</ul></div>
</div></div></nav></header><div class="container"><div class="row"><div class="col-md010"><ol class="breadcrumb"><li><a href="/index.html">Master Index</a></li><li><a href="../index.html">Eclass Reference</a></li></ol></div></div></div>
	<div class="container">
EOF
    # generate html pages and fix hyperlinks for eclass and ebuild man pages
    /bin/bunzip2 -c $i | /usr/bin/man2html -r - | \
    sed -e "/<A HREF=/s:=.*man.*/\(.*eclass\).*html\">:=../\1/index.html>:" \
    -e "/<\/BODY>/d" -e "/<\/HTML>/d"  \
    -e "/<A HREF=/s:=.*man.*/\(.*ebuild\).*html\">:=../\1/\index.html>:" >> ${TMP}
	# The first 4 lines are cruft for devmanual
	tail -n $(($(wc -l ${TMP} | awk '{print $1}') - 4)) ${TMP} >> ${FINAL}
	rm -f ${TMP}
	echo "${FOOTER}" >> ${FINAL}
done

# Remove old dirs (eclasses that were dropped from the tree)
find $OUTPUTDIR -mindepth 1 -maxdepth 1 -mtime +1 -exec rm -R {} \;

# build the index, rebuilding it each time
cat << EOF > $OUTPUTDIR/text.xml
<?xml version="1.0"?>
<guide self="eclass-reference/">
<chapter>
<title>Eclass Reference</title>

<body>
<p>
This section provides a reference for some of the more commonly used eclasses.
Note that most eclasses have an accompanying manual page. These man pages can be
installed by emerging <code class="docutils literal"><span class="pre">app-portage/eclass-manpages</span></code>.
</p>
</body>

<section>
<title>Contents</title>
<body>
<list-group-d>
EOF

for i in $(find $OUTPUTDIR/ -maxdepth 1 -mindepth 1 -type d | sort); do
	echo "<uri link=\"$(basename $i)/index.html\">$(basename $i) Reference</uri>" >> ${OUTPUTDIR}/text.xml
done

cat << EOF >> ${OUTPUTDIR}/text.xml

</list-group-d></body>
</section>
</chapter>
</guide>
EOF
