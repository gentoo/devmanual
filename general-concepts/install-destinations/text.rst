Install Destinations
====================

When an ebuild runs the ``src_install`` phase, it installs an image of the
package in question from ``${S}`` into ``${D}``. Ebuilds must *not* attempt to
perform any operation upon the live filesystem at this stage -- this will break
binaries, and will (often) cause a sandbox violation notice.

When installing, portage will install the image in ``${D}`` into ``${ROOT}``. By
default, ``${ROOT}`` points to ``/``, although the user can alter this -- for
example, the user may be building a minimal image for another system in a
different location. If your package must operate on the live filesystem (for
example, to create some cache files during ``pkg_postinst``), you must ensure
that you prefix any paths with ``${ROOT}``.

When inside ``pkg_preinst``, the image to be installed can be accessed under
``"${IMAGE}"``.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

