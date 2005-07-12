src_install
===========

+------------------+---------------------------------------------------+
| **Function**     | ``src_install``                                   |
+------------------+---------------------------------------------------+
| **Purpose**      | Install a package image to ``${D}``               |
+------------------+---------------------------------------------------+
| **Sandbox**      | Enabled                                           |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild                                            |
+------------------+---------------------------------------------------+

Default ``src_install``
-----------------------

.. CODESAMPLE src_install-1.ebuild

Sample ``src_install``
----------------------

.. CODESAMPLE src_install-2.ebuild

Easy Installs
-------------

Often, especially with autotools-powered packages, there is a ``Makefile``
``install`` target which will honour the ``DESTDIR`` variable to tell it to
install to a non-root location. If possible, this should be used:

.. CODESAMPLE src_install-3.ebuild

.. Note:: ``make`` should be used over ``emake`` here. Most installs are not
  designed to be parallelised.

Sometimes this will end up installing a few things into strange places. If and
only if this is the case, the ``einstall`` function can be used:

.. CODESAMPLE src_install-4.ebuild

It is usually necessary to include additional ``dodoc`` statements for the
``README``, ``ChangeLog`` etc in these cases.

Trivial Installs
----------------

For some packages with no ``Makefile`` that only install a small number of
files, writing a manual install using ``cp`` is the easiest option. For example,
to do a simple install of some (no compilation required) themes:

.. CODESAMPLE src_install-5.ebuild

Or sometimes a combination of ``insinto`` and ``doins`` (plus related functions
-- see `Install Functions Reference`_) -- the following is based upon the
``sys-fs/udev`` install:

.. CODESAMPLE src_install-6.ebuild

This is, of course, considerably harder to handle than a simple ``Makefile``
driven install.

Other Installs
--------------

Sometimes, there will be a ``Makefile`` that does not honour ``DESTDIR`` and a
non-trivial number of files to install. In these situations, it is best to patch
the ``Makefile`` and contact upstream explaining the situation to them.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

