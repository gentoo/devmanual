pkg_prerm
=========

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_prerm``                                     |
+------------------+---------------------------------------------------+
| **Purpose**      | Called before a package is unmerged.              |
+------------------+---------------------------------------------------+
| **Sandbox**      | Disabled                                          |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild, binary                                    |
+------------------+---------------------------------------------------+

Default ``pkg_prerm``
---------------------

.. CODESAMPLE pkg_prerm-1.ebuild

Sample ``pkg_prerm``
--------------------

.. CODESAMPLE pkg_prerm-2.ebuild

Common ``pkg_prerm`` Tasks
--------------------------

``pkg_prerm`` is used to clean up any files that would otherwise prevent a clean
unmerge.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

