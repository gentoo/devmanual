Eclass Writing Guide
====================

This section provides a brief introduction to eclass authoring.

.. Important:: You should reread the `Overlay and Eclasses`_ and `The Portage
  Cache`_ sections before continuing.

Purpose of Eclasses
-------------------

An eclass is a collection of code which can be used by more than one ebuild. At
the time of writing, all eclasses live in the ``eclass/`` directory in the tree.
Roughly speaking, there are three kinds of eclass:

* Those which provide common functions which are used by many ebuilds (for
  example, ``eutils``, ``versionator``, ``cvs``, ``bash-completion``)
* Those which provide a basic build system for many similar packages (for
  example, ``vim-plugin``, ``kde``)
* Those which handle one or a small number of packages with complex build
  systems (for example, ``vim``, ``toolchain``, ``kernel-2``)

Adding and Updating Eclasses
----------------------------

Before committing a new eclass to the tree, it should be emailed to the
gentoo-dev mailing list with a justification and a proposed implementation. Do
not skip this step -- sometimes a better implementation or an alternative which
does not require a new eclass will be suggested.

Before updating ``eutils`` or a similar widely used eclass, it is best to email
the gentoo-dev list. It may be that your proposed change is broken in a way you
had not anticipated, or that there is an existing function which performs the
same purpose, or that your function may be better off in its own eclass. If you
don't email gentoo-dev first, and end up breaking something, expect to be in a
lot of trouble.

If there is an existing maintainer for an eclass (this is usually the case), you
**must** talk to the maintainer before committing any changes.

It is not usually necessary to email the gentoo-dev list before making changes
to a non-general eclass which you maintain. Use common sense here.

.. Warning:: Committing a broken eclass can kill huge numbers of packages. Since
    ``repoman`` is not eclass-aware, be very sure you do proper testing.

A simple way to verify syntax is ``bash -n foo.eclass``.

Eclasses must **not** be removed from the tree, even if they are no longer used,
as this will cause problems for users who have installed packages which used the
eclass in question.

Basic Eclass Format
-------------------

An eclass is a ``bash`` script which is sourced within the ebuild environment.
Files should be a simple text file with a ``.eclass`` extension. Allowed
characters in the filename are lowercase letters, the digits 0-9, hyphens,
underscores and dots. Eclasses are not intrinsically versioned.

Eclasses should start with the standard ebuild header, along with comments
explaining the maintainer and purpose of the eclass, and any other relevant
documentation.

Eclass Variables
----------------

All eclasses must define two top level variables, ``ECLASS`` and ``INHERITED``.
The ``ECLASS`` variable must be set to the name of the eclass (without the
``.eclass`` suffix), and ``INHERITED`` must be set to ``"$INHERITED $ECLASS"``.

Other top level variables may be defined as for ebuilds. If any USE flags are
used, ``IUSE`` must be set. The ``KEYWORDS`` variable must **not** be set in an
eclass.

Eclass Functions
----------------

Eclasses may define functions. These functions will be visible to anything which
inherits the eclass.

Simple Common Functions Eclass Example
--------------------------------------

As an example, the following eclass was written to illustrate a better way of
installing OSX application files during a discussion on this subject. It defines
a single function, ``domacosapp``.

.. CODESAMPLE eclass-writing-1.ebuild

Export Functions
----------------

An eclass may provide default implementations for any of the standard ebuild
functions (``src_unpack``, ``pkg_postinst`` etc). This can be done either as a
simple function definition (which is not multiple eclass friendly) or using
``EXPORT_FUNCTIONS``. Functions given to ``EXPORT_FUNCTIONS`` are implemented
as normal, but have their name prefixed with ``${ECLASS}_``.

Important: Only 'standard' functions should be specified in
``EXPORT_FUNCTIONS``.

.. Note:: ``EXPORT_FUNCTIONS`` is a function, *not* a variable.

If multiple eclasses export the same function, the latest (inherited last)
defined version wins.  If an ebuild defines a function that is exported, this
gets priority over any eclass version. This can be used to override
eclass-defined defaults -- for example, say we had ``fnord.eclass``:

.. CODESAMPLE eclass-writing-2.ebuild

Then an ebuild could do this:

.. CODESAMPLE eclass-writing-3.ebuild

Simple Build System Eclass Example
----------------------------------

A simple eclass which defines a number of functions and a default
``src_compile`` for the (hypothetical) ``jmake`` build system might look
something like the following:

.. CODESAMPLE eclass-writing-4.ebuild

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
