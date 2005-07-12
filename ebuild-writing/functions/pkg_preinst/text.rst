pkg_preinst
===========

+------------------+---------------------------------------------------+
| **Function**     | ``pkg_preinst``                                   |
+------------------+---------------------------------------------------+
| **Purpose**      | Called before image is installed to ``${ROOT}``   |
+------------------+---------------------------------------------------+
| **Sandbox**      | Disabled                                          |
+------------------+---------------------------------------------------+
| **Privilege**    | root                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild, binary                                    |
+------------------+---------------------------------------------------+

Default ``pkg_preinst``
-----------------------

.. CODESAMPLE pkg_preinst-1.ebuild

Sample ``pkg_preinst``
----------------------

.. CODESAMPLE pkg_preinst-2.ebuild

Common Tasks
------------

There are a few things that are often done in ``pkg_preinst``:

* Adding users and groups -- see `Users and Groups`_
* Modifying the install image for a particular system. This function allows
  system-specific customisation to be done even when installing from a binary.
  The most useful example is probably smart configuration file updating -- a
  ``pkg_preinst`` could check a configuration file in ``${ROOT}/etc/`` and
  create a smart updated version in ``${IMAGE}/etc/`` (see `Install
  Destinations`_) rather than always trying to install the default configuration
  file (remember `Configuration File Protection`_).

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

