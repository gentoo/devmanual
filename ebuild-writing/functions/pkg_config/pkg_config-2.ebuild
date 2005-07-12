# Headers.

pkg_config() {
	if [ ! -d ${ROOT}/var/lib/mysql/mysql ] ; then
		einfo "Press ENTER to create the mysql database and set proper"
		einfo "permissions on it, or Control-C to abort now..."
		read
		${ROOT}/usr/bin/mysql_install_db
	else
		einfo "Hmm, it appears as though you already have the mysql"
		einfo "database in place.  If you are having problems trying"
		einfo "to start mysqld, perhaps you need to manually run"
		einfo "/usr/bin/mysql_install_db and/or check your config"
		einfo "file(s) and/or database(s) and/or logfile(s)."
	fi
}
