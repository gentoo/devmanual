#!/bin/bash

set -o pipefail

srcdir=$(cd "${BASH_SOURCE[0]%/*}" && pwd)
topdir=${srcdir%/*}

guesscompress() {
	case ${1} in
		*.gz|*.z)         echo "gzip -dc"  ;;
		*.bz2|*.bz)       echo "bzip2 -dc" ;;
		*.xz|*.lzma|*.lz) echo "xz -dc"    ;;
		*.lzo)            echo "lzop -dc"  ;;
		*.zst)            echo "zstd -dc"  ;;
		*)                echo "cat"       ;;
	esac
}

skel=$(xsltproc --param offline "${OFFLINE:-0}" "${topdir}"/devbook.xsl \
		- <<- 'EOF'
	<devbook self="eclass-reference/xyz/">
	<chapter><title>@TITLE@</title></chapter>
	</devbook>
	EOF
) || exit
header=${skel%%<main>*}
footer=${skel##*</main>}

for manpage; do
	basename=${manpage##*/}
	case ${basename} in
		*.gz|*.z|*.bz2|*.bz|*.xz|*.lzma|*.lz|*.lzo|*.zst)
			basename=${basename%.*} ;;
	esac
	dirname=${basename%.5}
	[[ ${dirname} != "${basename}" ]] || exit
	output=${dirname}/index.html
	decompress=$(guesscompress "${manpage}")
	mkdir -p "${dirname}" || exit
	# Format the man page in HTML
	printf '%s\n%s\n' "${header//@TITLE@/${dirname}}" \
		'<main><div class="container">' > "${output}" || exit
	# Generate HTML and fix hyperlinks for eclasses and other man pages
	${decompress} "${manpage}" | /usr/bin/man2html -r \
	| sed -e '1,/<BODY>/d;/<\/BODY>/,$d' \
		-e '/<A HREF=/s:"\.\./man5/\([^"]*eclass\|ebuild\|make\.conf\)\.5\.html":"../\1/index.html":g' \
		-e 's:<A HREF="\.\./man[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's:<A HREF="[^"]*//localhost/[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's:<A HREF="[^"]*\${[^"]*">\([^<>]*\)</A>:\1:g' \
		-e 's,<A HREF="mailto:[^"]*">\([^<>]*\)</A>,\1,g' \
		-e 's:\[ti\]:~:g' \
		-e 's:<TT>\([^<>]*\)</TT>:\1:g' \
		-e 's:<DL COMPACT>:<DL>:g' \
		-e 's:<TR VALIGN=top>:<TR>:g' \
		-e '/<A NAME/{N;s:<A NAME=\(.*\)>.*</A>\(.*<H[1-6]\)>:\2 ID=\1>:}' \
		>> "${output}" || exit
	printf '%s\n%s' '</div></main>' "${footer}" >> "${output}" || exit
done

# Local Variables:
# tab-width: 4
# indent-tabs-mode: t
# End:
