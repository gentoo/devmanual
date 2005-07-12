# Headers.

src_install() {
	dobin udevinfo
	dobin udevtest
	into /
	dosbin udev
	dosbin udevd
	dosbin udevsend
	dosbin udevstart
	dosbin extras/scsi_id/scsi_id
	dosbin extras/volume_id/udev_volume_id

	exeinto /etc/udev/scripts
	doexe extras/ide-devfs.sh
	doexe extras/scsi-devfs.sh
	doexe extras/cdsymlinks.sh
	doexe extras/dvb.sh

	insinto /etc/udev
	newins ${FILESDIR}/udev.conf.post_050 udev.conf
	doins extras/cdsymlinks.conf

	# For devfs style layout
	insinto /etc/udev/rules.d/
	newins etc/udev/gentoo/udev.rules 50-udev.rules

	# scsi_id configuration
	insinto /etc
	doins extras/scsi_id/scsi_id.config

	# set up symlinks in /etc/hotplug.d/default
	dodir /etc/hotplug.d/default
	dosym ../../../sbin/udevsend /etc/hotplug.d/default/10-udev.hotplug

	# set up the /etc/dev.d directory tree
	dodir /etc/dev.d/default
	dodir /etc/dev.d/net
	exeinto /etc/dev.d/net
	doexe etc/dev.d/net/hotplug.dev

	doman *.8
	doman extras/scsi_id/scsi_id.8

	dodoc COPYING ChangeLog FAQ HOWTO-udev_for_dev README TODO
	dodoc docs/{overview,udev-OLS2003.pdf,udev_vs_devfs,RFC-dev.d,libsysfs.txt}
	dodoc docs/persistent_naming/* docs/writing_udev_rules/*

	newdoc extras/volume_id/README README_volume_id
}
