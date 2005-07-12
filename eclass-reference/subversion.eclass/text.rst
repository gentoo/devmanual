``subversion.eclass`` Reference
===============================

The ``subversion`` eclass provides functions that enable the ebuild author to
create 'live' ebuilds that fetch the program's sources from a subversion
repository.

See `Subversion Sources`_ for an introduction.

``subversion.eclass`` Variables
-------------------------------

==================== ====================================================
Variables            Details
==================== ====================================================
``ESVN_REPO_URI``    URI from which the sources will be fetched.  Valid
                     protocols: http, https, and svn.  At a minimum, this
                     variable *must* be set.
``ESVN_STORE_DIR``   Location fetched sources will be kept.  Defaults to
                     ``${DISTDIR}/svn-src``.
``ESVN_FETCH_CMD``   Command used for initial checkout.  Defaults to
                     ``svn checkout``.
``ESVN_UPDATE_CMD``  Command used for updating sources.  Defaults to
                     ``svn update``.
``ESVN_PROJECT``     Name of the project.  Defaults to ``${PN/-svn}``.
``ESVN_BOOTSTRAP``   Name of bootstrap script.  This variable is empty by
                     default.  './' is automatically prepended.
``ESVN_PATCHES``     List of patches to apply prior to fetching the
                     sources.  In addition to literal filenames, you may
                     also use globbing such as \*.diff.  This variable is
                     empty by default.
==================== ====================================================

``subversion.eclass`` Functions
-------------------------------

========================== ==============================================
Functions                  Details
========================== ==============================================
``subversion_src_unpack``  The default ``src_unpack`` that runs
                           ``subversion_svn_fetch`` and
                           ``subversion_bootstrap``.
``subversion_svn_fetch``   Fetches the program's sources from the URI
                           specified by ``ESVN_REPO_URI`` and copies to
                           ``${S}``.
``subversion_bootstrap``   Applies any patches specified by
                           ``ESVN_PATCHES`` and executes the bootstrap
                           script specified by ``ESVN_BOOTSTRAP``.
========================== ==============================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
