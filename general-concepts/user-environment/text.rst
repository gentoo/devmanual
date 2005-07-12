User Environment
================

User environment variables and ``make.conf`` settings get passed on to ebuilds.
This can be useful -- it's how ``CFLAGS`` and friends work, for example -- but
it can also result in nasty build-breaking variables like ``LANG`` and
``LC_ALL`` getting through. Currently no sanitisation is performed upon the
environment.

Filtering Variables
-------------------

Certain variables will really really upset certain build systems. A good example
is the locale variables (``LC_ALL`` et al), which if set to certain values will
cause ``sed`` or ``grep`` expressions involving the likes of ``[A-Z]`` to fail.
The easiest thing to do here is to ``unset`` or sanitise the offending variables
inside ``pkg_setup``.

The simplest way to unset all locale-related variables is:

.. CODESAMPLE filtering-1.ebuild

Not Filtering Variables
-----------------------

On the other hand, it is extremely important that certain user preferences are
honoured as far as possible. A good example is ``CFLAGS``, which *must* be
respected (selective filtering is fine, but outright ignoring is not). Ignoring
``CFLAGS`` when compiling can cause serious problems:

* Ignoring ``march/mcpu`` may force kernel or software emulation for certain
  opcodes on some architectures. This can be *very* slow -- for example,
  ``openssl`` built for SPARC v7 but run on v9 is around five times slower for
  RSA operations.

* Stripping certain ABI-related flags will break linkage.

* Stripping certain ABI-related flags will result in invalid code being produced
  for certain setups. In extreme cases, we could end up with daft things like
  big endian code being produced for little endian CPUs.

* If a user's ``march/mcpu/mtune`` is ignored, and an auto-detected setting is
  used instead, GRP and stages will break. For example, ``i686`` stages could no
  longer be produced on a ``pentium-4``, and ``v8`` stages could no longer be
  produced on an ``UltraSparc``.

Some packages do this by accident. For example, one might see
``CFLAGS=-Wall`` in ``Makefile.am``. To fix this, either ``sed`` in the user's
``CFLAGS``, or (the better solution) change the variable to ``AM_CFLAGS``, which
will automatically be merged with the user's settings.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

