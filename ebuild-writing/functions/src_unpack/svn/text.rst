Subversion Sources
==================

As with CVS, an eclass exists for working directly with upstream Subversion
repositories. See `subversion.eclass Reference`_ for a full list of functions
and variables.

Disavantages of Subversion Sources
----------------------------------

Note that Subversion ebuilds should **not** generally be added to the tree
(except under ``package.mask``) for much the same reasons that live CVS ebuilds
should not (see `Disadvantages of CVS Sources`_). Indeed, there should be even
less impetus to add a live Subversion ebuild than a live CVS ebuild, as
Subversion checkouts are roughly a factor of five larger than an equivalent CVS
checkout.

It is far safer to make a snapshot instead. For example, ``gentoo-syntax``
snapshots could be (but aren't, because ciaranm is so lazy he automated it)
made using: ::

    $ svn export svn://svn.berlios.de/svnroot/repos/gentoo-syntax -r HEAD gentoo-syntax

Disadvantages of Subversion Live Sources
----------------------------------------

Live Subversion ebuilds that work against ``HEAD`` have the same disadvantages
as Live CVS ebuilds.

Using Subversion Sources
------------------------

To use a Subversion source, ``subversion.eclass`` must be inherited, and then at
least ``ESVN_REPO_URI`` must be set. The following variables are also noteworthy:

=================== ========================================= ================
Variable            Purpose                                    Example
=================== ========================================= ================
``ESVN_REPO_URI``   Server and path (http, https, svn)        ``"svn://svn.example.com/foobar/trunk"``
``ESVN_STORE_DIR``  Unpack location                           ``ESVN_STORE_DIR="${DISTDIR}/svn-src"``
``ESVN_PROJECT``    Project name of ebuild                    ``ESVN_PROJECT="${PN/-svn}"``
``ESVN_BOOTSTRAP``  Bootstrap command or script               ``ESVN_BOOTSTRAP="autogen.sh"``
``ESVN_PATCHES``    Patches to apply during bootstrap         ``ESVN_PATCHES="${FILESDIR}/*.patch"``
=================== ========================================= ================

See the eclass itself and `subversion.eclass Reference`_ for the full range of
options.

To perform the actual checkout, use the ``subversion_src_unpack`` function,
which calls both ``subversion_svn_fetch`` and ``subversion_bootstrap`` itself.

Here is a simple snippet, based upon the Subversion options in
``litu-svn-20040902.ebuild``:

.. CODESAMPLE svn-1.ebuild

This approach is sufficient for most Subversion ebuilds.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
