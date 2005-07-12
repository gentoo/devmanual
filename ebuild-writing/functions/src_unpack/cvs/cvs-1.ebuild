# Headers.

inherit cvs

SRC_URI=""

src_unpack() {
	ECVS_SERVER="cvs.sourceforge.net:/cvsroot/vim"
	ECVS_USER="anonymous"
	ECVS_PASS=""
	ECVS_AUTH="pserver"
	if [[ $(get_major_version ) -ge 7 ]] ; then
		ECVS_MODULE="vim7"
	else
		ECVS_MODULE="vim"
	fi
	ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_MODULE}
	cvs_src_unpack
}
