Ebuild Revisions
================

Ebuilds may have a Gentoo revision number associated with them. This is a
``-rX`` suffix, where ``X`` is an integer -- see `File Naming Rules`_. This
component must only be used for Gentoo changes, not upstream releases. By
default, ``-r0`` is implied and should not be specified manually.

Ebuilds should have their ``-rX`` incremented whenever a change is made which
will make a substantial difference to what gets installed by the package -- by
substantial, we generally mean "something for which many users would want to
upgrade". This is usually for bugfixes.

Simple compile fixes do **not** warrant a revision bump; this is because they do
not affect the installed package for users who already managed to compile it.
Small documentation fixes are also usually not grounds for a new revision.

When doing a revision bump, the usual rules about dropping to ``~arch`` apply.
See `Keywording on Upgrades`_.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


