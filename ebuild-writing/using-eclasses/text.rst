Using Eclassses
===============

An eclass is a collection (library) of functions or functionality that is shared
between packages. See `Eclass Writing Guide`_ for the full story on what
eclasses can do, how they work and how to write them, and `Eclass Reference`_
for documentation on various commonly used eclasses. This section only explains
how to use an eclass which has already been written.

The ``inherit`` Function
------------------------

To use an eclass, it must be 'inherited'. This is done via the ``inherit``
function, which is provided by ``ebuild.sh``. The ``inherit`` statement must
come at the top of the ebuild, *before* any functions. Conditional inherits are
illegal (except where the inheritance criteria are cache-constant -- see `The
Portage Cache`_).

After inheriting an eclass, its provided functions can be used as normal. Here's
``devtodo-0.1.18-r2.ebuild``, which uses three eclasses:

.. CODESAMPLE devtodo.ebuild

Note the ``inherit`` immediately after the header.

The ``eutils`` eclass (see `eutils.eclass Reference`_) is needed to get the
``epatch`` function.  The ``flag-o-matic`` eclass (see `flag-o-matic.eclass
Reference`_) is needed for ``replace-flags``, and the ``bash-completion`` eclass
(`bash-completion.eclass Reference`_) is used to handle the bash completion file
via ``dobashcompletion`` and ``bash-completion_pkg_postinst``.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

