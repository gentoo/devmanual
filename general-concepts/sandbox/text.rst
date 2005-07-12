Sandbox
=======

During the ``src_unpack``, ``src_compile``, ``src_test`` and ``src_install``
phases, ``ebuild.sh`` operates inside a *sandbox*. This is a special environment
which attempts to help prevent badly written ebuilds (or ebuilds working with
badly written build systems) accidentally writing outside of permitted locations.

**All packages must build correctly when sandbox is active.** Packages must not
achieve this by using sneaky tricks to make sandbox warnings not show up -- the
sandbox is there to ensure that binary packages will work correctly, and that
a badly written ``Makefile`` won't cause problems. Using ``addwrite`` is
generally **not** the correct solution.

See `Sandbox Functions Reference`_ for details on sandbox-related functions. See
`Handling Access Violations`_ for suggestions on fixing sandbox-related build
problems.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

