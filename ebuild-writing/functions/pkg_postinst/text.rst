pkg_postinst
============

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_postinst``                                  |
+------------------+---------------------------------------------------+
| **Purpose**      | Called after image is installed to ``${ROOT}``    |
+------------------+---------------------------------------------------+
| **Sandbox**      | Disabled                                          |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild, binary                                    |
+------------------+---------------------------------------------------+

Default ``pkg_postinst``
------------------------

.. CODESAMPLE pkg_postinst-1.ebuild

Sample ``pkg_postinst``
-----------------------

.. CODESAMPLE pkg_postinst-2.ebuild

Common ``pkg_postinst`` Tasks
-----------------------------

The most common use for ``pkg_postinst`` is to display post-install
informational messages or warnings. Note that ``has_version`` will operate on
the version that *was* installed, which can be useful for selective upgrade
messages.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

