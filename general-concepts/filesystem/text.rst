Filesystem
==========

The basic filesystem layout and purpose is as follows:

* ``/bin``: Boot-critical applications
* ``/etc``: System administrator controlled configuration files
* ``/lib``: Boot-critical libraries
* ``/opt``: Binary-only applications.
* ``/sbin``: System administrator boot-critical applications
* ``/tmp``: Temporary data
* ``/usr``: General applications

  + ``/usr/bin``: Applications
  + ``/usr/lib``: Libraries
  + ``/usr/local``: Non-portage applications. **Ebuilds must not install here**.
  + ``/usr/sbin``: Non-system-critical system administrator applications
  + ``/usr/share``: Architecture independent application data and documentation

* ``/var``: Program generated data

  + ``/var/cache``: Long term data which can be regenerated
  + ``/var/lib``: General application generated data
  + ``/var/log``: Log files

Where possible, we prefer to put non-boot-critical applications in ``/usr``
rather than ``/``. If a program is not needed in the boot process until after
filesystems are mounted then it generally does not belong on ``/``.

Any binary which links against a library under ``/usr`` must itself go into
``/usr`` (or possibly ``/opt``).

The ``/opt`` top-level should only be used for binary-only applications.
Binary-only applications must not be installed outside of ``/opt``.

The ``/usr/local`` heirarchy is for non-portage software. Ebuilds must not
attempt to put anything in here.

The ``/usr/share`` directory is for *architecture independent* application data
which is not modified at runtime.

Try to avoid installing unnecessary things into ``/etc`` -- every file in there
is additional work for the system administrator. In particular, non-text files
and files that are not intended for system administrator usage should be moved
to ``/usr/share``.

FHS
---

Gentoo does not consider the `Filesystem Hierarchy Standard
<http://www.pathname.com/fhs/>`__ to be an authoritative standard, although much
of our policy coincides with it.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

