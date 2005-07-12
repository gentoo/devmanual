pkg_nofetch
===========

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_nofetch``                                   |
+------------------+---------------------------------------------------+
| **Purpose**      | Tell the user how to deal with fetch-restricted   |
|                  | packages.                                         |
+------------------+---------------------------------------------------+
| **Sandbox**      | Enabled                                           |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild                                            |
+------------------+---------------------------------------------------+

Default ``pkg_nofetch``
-----------------------

.. CODESAMPLE pkg_nofetch-1.ebuild

Example ``pkg_nofetch``
-----------------------

.. CODESAMPLE pkg_nofetch-2.ebuild

Notes on ``pkg_nofetch``
------------------------

This function is only triggered for packages which have ``RESTRICT="fetch"``
(see `Restricting Automatic Mirroring`_) set, and only if one or more components
listed in ``SRC_URI`` are not already available in the ``distfiles`` directory.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

