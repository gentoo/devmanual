The Portage Cache
==================

Portage uses a cache for most top-level variables (``DEPEND``, ``DESCRIPTION``,
``SRC_URI`` and so on). This cache may be generated on a different machine, so
these variables must be either static or generated using only unchanging
'version / name' variables (``P``, ``PN``, ``PV``, ``PR``, ``PVR`` and ``PF``).

So, the following will not work:

.. CODESAMPLE bad-cache-dep-sample.ebuild

However, this is legal, since ``versionator.eclass`` works upon ``PV``, and
``PV`` and ``PN`` are both static:

.. CODESAMPLE good-cache-dep-sample.ebuild

Conditional Inherits
--------------------

Because eclasses modify various cached variables, conditional inheritance is not
allowed except where the same results will always be obtained on every system.
For example, inherits based upon USE flags are illegal, but inherits based
solely upon ``PN`` are allowed.

As an example of a legal and possibly useful conditional inherit, some eclasses
do:

.. CODESAMPLE conditional-inherit.ebuild

This allows the same eclass to be used for both regular and ``-cvs`` packages.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
