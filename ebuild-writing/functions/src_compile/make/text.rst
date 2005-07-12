Building
========

The ``emake`` function should be used to call ``make``. This will ensure that
the user's ``MAKEOPTS`` are used correctly. The ``emake`` function passes on
any arguments provided, so it can be used to make non-default targets (``emake
extras``), for example. Occasionally you might encounter a screwy non-autotools
``Makefile`` that explodes with ``emake``, but this is rare.

Builds should be tested with various ``-j`` settings in ``MAKEOPTS`` to ensure
that the build parallelises properly. If a package does *not* parallelise
cleanly, it should be patched.

If patching *really* isn't an option, ``emake -j1`` should be used. However,
when doing this please remember that you are seriously hurting build times for
many non-x86 users in particular. Forcing a ``-j1`` can increase build times
from a few minutes to an hour on some MIPS and SPARC systems.

Fixing Compiler Usage
---------------------

Sometimes a package will try to use a bizarre compiler, or will need to be told
which compiler to use. In these situations, the ``tc-getCC()`` function from
``toolchain-funcs.eclass`` should be used. Other similar functions are available
-- these are documented in `toolchain-funcs.eclass-5`_.

.. Note:: It is *not* correct to use the ``${CC}`` variable for this purpose.

Sometimes a package will not use the user's ``${CFLAGS}``. This must be worked
around, as sometimes this variable is used for specifying critical ABI options.
In these cases, the build scripts should be modified (for example, with ``sed``)
to use ``${CFLAGS}`` correctly.

.. CODESAMPLE getcc-sample.ebuild

.. Note:: When using ``sed`` with ``CFLAGS``, it is not safe to use a comma or a
    slash as a delimiter. The vapier-recommended character is a colon.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

