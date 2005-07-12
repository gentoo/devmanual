CVS Sources
===========

Rather than working with a source tarball, it is possible to use upstream's CVS
server directly. This can be useful when there is a need to test unreleased
snapshots on a regular basis.

Disadvantages of CVS Sources
----------------------------

Note that CVS ebuilds should **not** generally be added to the tree (except
under ``package.mask``) for the following reasons:

* Upstream CVS servers tend to be far less reliable than our mirroring system
  (particularly if we're talking Sourceforge...).

* CVS ebuilds create a very heavy server load -- not only is CVS not mirrored,
  but allowing a CVS checkout is considerably more work for a server than simply
  serving up a file via HTTP or FTP.

* Many users who are behind firewalls cannot use CVS.

It is safer to make a snapshot instead. For example, ``vim`` snapshots are made
using: ::

    $ cvs -z3 -d :pserver:anonymous@cvs.sourceforge.net:/cvsroot/vim export -r HEAD vim

Disadvantages of CVS Live Sources
---------------------------------

CVS ebuilds which work against ``HEAD`` rather than a specific date or revision
are even worse candidates for tree inclusion:

* You can never be sure whether upstream's CVS will actually build at any given
  point.

* It is extremely difficult to track down bugs when you cannot install the same
  version of a package as the reporter.

* Many upstream packages tend to get upset if people aren't using a specific
  released version.

Using CVS Sources
-----------------

To use a CVS source, ``cvs.eclass`` must be inherited, and then a number of
variables must be set. The following variables are often useful:

================= ================ ========================
Variable          Purpose          Example
================= ================ ========================
``ECVS_SERVER``   Server and path  ``"cvs.sourceforge.net:/cvsroot/vim"``
``ECVS_MODULE``   Module           ``"vim"``
``ECVS_BRANCH``   Branch           ``"HEAD"``
``ECVS_AUTH``     Auth method      ``"ext"``
``ECVS_USER``     Username         ``"anoncvs"``
``ECVS_PASS``     Password         ``""``
``ECVS_TOPDIR``   Unpack location  ``ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"``
================= ================ ========================

See the eclass itself for the full range of options.

Then, to perform the actual checkout, use the ``cvs_src_unpack`` function.

Here's a simple snippet, based upon the CVS options in ``vim.eclass``:

.. CODESAMPLE cvs-1.ebuild

Here's another approach, based upon the ``emacs-cvs`` ebuild, which relies upon
the default ``src_unpack`` provided in the eclass:

.. CODESAMPLE cvs-2.ebuild

This approach is simpler but less flexible.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
