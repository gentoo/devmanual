Configuring Build Environment
=============================

Sometimes it is necessary to manipulate certain aspects of the user's build
environment before running ``./configure``. The ``flag-o-matic`` eclass is the
best choice for manipulating ``CFLAGS``, ``LDFLAGS`` and suchlike.

.. Note:: Except where otherwise specified, any function which operates on
    ``CFLAGS`` also operates on ``CXXFLAGS``.

Ebuilds must not simply ignore use ``CFLAGS`` -- see `Not Filtering Variables`_.

Guidelines for Flag Filtering
-----------------------------

If a package breaks with any reasonable ``CFLAGS``, it is best to filter the
problematic flag if a bug report is received. Reasonable ``CFLAGS`` are
``-march=``, ``-mcpu=``, ``-mtune=`` (depending upon arch), ``-O2``, ``-Os`` and
``-fomit-frame-pointer``. Note that ``-Os`` should usually be replaced with
``-O2`` rather than being stripped entirely. The ``-fstack-protector`` flag
should probably be in this group too, although our hardened team claim that this
flag never ever breaks anything...

The ``-pipe`` flag doesn't affect the generated code, so it's not really
relevant here, but it's a sensible flag to have set globally.

If a package breaks with other ``CFLAGS``, it is perfectly ok to close the bug
with a **WONTFIX** suggesting that the user picks more sensible global
``CFLAGS``.  Similarly, if you suspect that a bug is caused by insane CFLAGS, an
**INVALID** resolution is suitable.

All of the following assumes that the ebuild has an ``inherit flag-o-matic``
line in the correct place.

Simple Flag Stripping
---------------------

The ``filter-flags`` function can be used to remove a particular flag from
``CFLAGS``. Multiple arguments can be supplied; each is the name of a flag to
remove.

.. CODESAMPLE filter-sample.ebuild

There is a ``filter-ldflags`` function available which does the equivalent for
``LDFLAGS``.

If a package is known to be very ``CFLAGS`` sensitive, the ``strip-flags``
function will remove most flags, leaving only a minimal conservative set of
flags.

.. CODESAMPLE strip-sample.ebuild

Flag Replacement
----------------

To replace a flag with a different one, use ``replace-flags``. This is most
commonly used to replace ``-Os`` with ``-O2`` (or ``-O3`` with ``-O2`` if you
are feeling kind).

.. CODESAMPLE replace-sample.ebuild

There is also a special function named ``replace-cpu-flags`` for replacing CPU
(``-mtune``, ``-mcpu``, ``-march``) designation flags. The last argument is the
flag to use; previous arguments are the flags to be replaced.

.. CODESAMPLE cpu-sample.ebuild

Adding Additional Flags
-----------------------

Sometimes it is necessary to add in additional ``CFLAGS`` or ``LDFLAGS``. The
``append-flags`` and ``append-ldflags`` functions can be used here.

.. CODESAMPLE ldflags-sample.ebuild

See `flag-o-matic.eclass Reference`_ for a full reference.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
