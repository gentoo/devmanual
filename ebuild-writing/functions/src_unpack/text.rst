src_unpack
==========

+------------------+---------------------------------------------------+
| **Function**     | ``src_unpack``                                    |
+------------------+---------------------------------------------------+
| **Purpose**      | Extract source packages and do any necessary      |
|                  | patching or fixes.                                |
+------------------+---------------------------------------------------+
| **Sandbox**      | Enabled                                           |
+------------------+---------------------------------------------------+
| **Privilege**    | user                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild                                            |
+------------------+---------------------------------------------------+

Default ``src_unpack``
----------------------

.. CODESAMPLE src_unpack-1.ebuild

Sample ``src_unpack``
---------------------

.. CODESAMPLE src_unpack-2.ebuild

Unpacking Tarballs
------------------

The ``unpack`` function should be used to unpack tarballs, compressed files and
so on. Do not use ``tar``, ``gunzip`` etc. manually.

The ``${A}`` variable contains all of the ``SRC_URI`` components, except for any
which are excluded by USE-based conditionals inside ``SRC_URI`` itself. If
multiple archives require unpacking in a particular order it is usually simpler
to avoid working with ``${A}``.

``src_unpack`` Actions
----------------------

The following subsections cover different topics which often occur when writing
``src_unpack`` functions.

.. CHILDLIST

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

