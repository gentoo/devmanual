pkg_postrm
==========

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_postrm``                                    |
+------------------+---------------------------------------------------+
| **Purpose**      | Called after a package is unmerged.               |
+------------------+---------------------------------------------------+
| **Sandbox**      | Disabled                                          |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild, binary                                    |
+------------------+---------------------------------------------------+

Default ``pkg_postrm``
----------------------

.. CODESAMPLE pkg_postrm-1.ebuild

Sample ``pkg_postrm``
---------------------

.. CODESAMPLE pkg_postrm-2.ebuild

Common ``pkg_postrm`` Tasks
---------------------------

``pkg_postrm`` is used to update symlinks, cache files and other generated
content after a package has been uninstalled.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

