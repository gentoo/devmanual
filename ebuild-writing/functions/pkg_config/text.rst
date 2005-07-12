pkg_config
==========

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_config``                                    |
+------------------+---------------------------------------------------+
| **Purpose**      | Run any special post-install configuration        |
+------------------+---------------------------------------------------+
| **Sandbox**      | Disabled                                          |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | manual                                            |
+------------------+---------------------------------------------------+

Default ``pkg_config``
----------------------

.. CODESAMPLE pkg_config-1.ebuild

Example ``pkg_config``
----------------------

Taken from the ``mysql`` ebuilds. Note the use of ``${ROOT}``.

.. CODESAMPLE pkg_config-2.ebuild

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


