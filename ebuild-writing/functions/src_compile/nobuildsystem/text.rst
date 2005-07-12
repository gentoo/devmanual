No Build System
===============

Occasionally some really small packages are shipped simply as a single ``.c`` file.
In these circumstances, you can either write your own ``Makefile`` and ship it
with the source tarball, or just manually compile the thing from within the
ebuild. Here's an example, from ``app-misc/hilite``:

.. CODESAMPLE nobuildsystem-1.ebuild

Here's an example from ``x11-plugins/gkrelltop``, which ships with a
``Makefile`` that doesn't actually work:

.. CODESAMPLE nobuildsystem-2.ebuild

A possibly better alternative would be to patch the ``Makefile`` and send it
upstream.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
