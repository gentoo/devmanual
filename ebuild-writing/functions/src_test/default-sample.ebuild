#

src_test()
{
	addpredict /
	if make check -n &> /dev/null; then
			echo ">>> Test phase [check]: ${CATEGORY}/${PF}"
			if ! make check; then
					hasq maketest $FEATURES && die "Make check failed. See above for details."
					hasq maketest $FEATURES || eerror "Make check failed. See above for details."
			fi
	elif make test -n &> /dev/null; then
			echo ">>> Test phase [test]: ${CATEGORY}/${PF}"
			if ! make test; then
					hasq maketest $FEATURES && die "Make test failed. See above for details."
					hasq maketest $FEATURES || eerror "Make test failed. See above for details."
			fi
	else
			echo ">>> Test phase [none]: ${CATEGORY}/${PF}"
	fi
	SANDBOX_PREDICT="${SANDBOX_PREDICT%:/}"
}
