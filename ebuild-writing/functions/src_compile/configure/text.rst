Configuring a Package
=====================

Many packages come with an autoconf-generated ``./configure`` script for
checking the build environment and configuring optional support for libraries.
The ``econf`` function should be used where possible -- this will provide
correct build and path specifications for a Gentoo environment.

Often the configure script will try to automatically enable support for optional
components based upon installed packages. This must **not** be allowed to
happen. For example, if a user has ``perl`` installed but has ``USE="-perl"``,
packages with optional ``perl`` support must not link against ``perl``. This
automatic detection can usually be overridden using ``--enable-`` and
``--disable`` or ``--with-`` and ``--without-`` switches (but note that these
don't always work -- make sure these are tested properly).

The ``use_enable`` and ``use_with`` utility functions should, where appropriate,
be used to generate these switches.

.. CODESAMPLE use-sample.ebuild

Sometimes the package's choice of name for the option will not exactly match the
name or case of the ``USE`` flag. This is *very* often the case with the ``X``
flag. For these situations, there are two argument forms:

.. CODESAMPLE use2-sample.ebuild

To check for an unset ``USE`` flag, the ``use_enable !flag`` form can be used.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
