# is $foo zero length?
if [[ -z "${foo}" ]] ; then
	die "Please set foo"
fi

# is $foo equal to "moo"?
if [[ "${foo}" == "moo" ]] ; then
	einfo "Hello Larry"
fi

# does "${ROOT}/etc/deleteme" exist?
if [[ -f "${ROOT}/etc/deleteme" ]] ; then
	einfo "Please delete ${ROOT}/etc/readme manually!"
fi
