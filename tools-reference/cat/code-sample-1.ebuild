# Header.

src_install() {
	# ...
	cat <<- EOF > ${D}/etc/mail/trusted-users
		# trusted-users - users that can send mail as others without a warning
		# apache, mailman, majordomo, uucp are good candidates
	EOF
	# ...
}
