src_compile
===========

+------------------+---------------------------------------------------+
| **Function**     | ``src_compile``                                   |
+------------------+---------------------------------------------------+
| **Purpose**      | Configure and build the package.                  |
+------------------+---------------------------------------------------+
| **Sandbox**      | Enabled                                           |
+------------------+---------------------------------------------------+
| **Privilege**    | user                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild                                            |
+------------------+---------------------------------------------------+

Default ``src_compile``
-----------------------

.. CODESAMPLE default-sample.ebuild

Sample ``src_compile``
----------------------

.. CODESAMPLE sample-sample.ebuild


Build Processes
---------------

Depending upon the build process used by upstream, there are a number of
possible things that may be done during ``src_compile``:

.. CHILDLIST

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

