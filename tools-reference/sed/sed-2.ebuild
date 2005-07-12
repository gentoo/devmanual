# Header.

# Add in the Gentoo -r number to fluxbox -version output. We need to look
# for the line in version.h.in which contains "__fluxbox_version" and append
# our content to it.
if [[ "${PR}" == "r0" ]] ; then
	suffix="gentoo"
else
	suffix="gentoo-${PR}"
fi
sed -i \
	-e "s~\(__fluxbox_version .@VERSION@\)~\1-${suffix}~" \
	version.h.in || die "version sed failed"
