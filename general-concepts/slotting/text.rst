Slotting
========

Packages can support having multiple versions installed simultaneously. This is
useful for libraries which may have changed interfaces between versions -- for
example, the ``gtk+`` package can install both versions ``1.2`` and ``2.6`` in
parallel. This feature is called slotting.

Most packages have no need for slotting. These packages specify ``SLOT="0"`` in
the ebuilds. This is **not** the same as specifying an empty slot -- an empty
slot means "disable slotting entirely", and should not be used.

Portage permits at most one instance of a package installation *per ``SLOT``
value*.  For example, say we have the following:

* ``foo-1.1`` with ``SLOT="1"``
* ``foo-1.2`` with ``SLOT="1"``
* ``foo-2.0`` with ``SLOT="2"``
* ``foo-2.1`` with ``SLOT="2"``

Then the user could have, say, ``foo-1.2`` and ``foo-2.0`` installed in
parallel, but *not* ``foo-1.1`` and ``foo-1.2``. Note that it is entirely
possible that the user may have ``foo-2.0`` installed and no ``foo-1.x`` at all.

It is not possible to ``DEPEND`` upon a package in a specific slot.

Currently portage will accept an arbitrary string for the value of ``SLOT``. For
future compatibility, it is recommended that slots contain only characters which
are allowed in an ebuild name or version (alphanumerics, hypens, full stops,
underscores, the plus character) -- other characters may cause problems with
future portage enhancements.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

