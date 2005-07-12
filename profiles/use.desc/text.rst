Profiles ``use.desc`` and ``use.local.desc`` Files
==================================================

The ``use.desc`` file contains a list of all global non-expanded ``USE`` flags,
together with a short description. This file should not be modified without
discussion on the ``gentoo-dev`` list.

The ``use.local.desc`` file contains a list of all local ``USE`` flags, together
with the relevant packages, and a short description. This file can be added to
without general discussion.

Having a small number of packages using identically named local ``USE`` flags is
allowed. If the number starts to grow substantially, it may be worth proposing
that the flag becomes a global -- see `Local and Global USE Flags`_.

All non-expand flags must be listed in exactly one of these files.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
