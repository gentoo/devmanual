#

	# If we're using selinux, we need to add a -D
	use selinux && append-flags "-DWITH_SELINUX"

	# Secure linking needed, since we're setuid root
	append-ldflags -Wl,-z,now
