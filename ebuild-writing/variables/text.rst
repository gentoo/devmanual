Variables
=========

There are a number of special variables which must be set in ebuilds, and many
more which can optionally be specified. There are also some predefined variables
which are of use throughout the ebuild.

Predefined Read-Only Variables
------------------------------

The following variables are defined for you. You must not attempt to set
them.

============= =======================================================
Variable      Purpose
============= =======================================================
``P``         Package name and version (excluding revision, if any), for example ``vim-6.3``
``PN``        Package name, for example ``vim``
``PV``        Package version (excluding revision, if any), for example ``6.3``
``PR``        Package revision, or ``r0`` if no revision exists.
``PVR``       Package version and revision, for example ``6.3-r0``, ``6.3-r1``.
``PF``        Package name, version and revision, for example
              ``vim-6.3-r1``
``A``         All the source files for the package (excluding those
              which are not available because of ``USE`` flags)
``CATEGORY``  Package's category, for example ``app-editors``.
``FILESDIR``  Path to the ebuild's ``files/`` directory, commonly used
              for small patches and files. Value:
              ``"${PORTDIR}/${CATEGORY}/${PN}/files"``.
``WORKDIR``   Path to the ebuild's root build directory. Value:
              ``"${PORTAGE_TMPDIR}/portage/${PF}/work"``.
``T``         Path to a temporary directory which may be used by the
              ebuild. Value: ``"${PORTAGE_TMPDIR}/portage/${PF}/temp"``
``D``         Path to the temporary install directory. Value:
              ``"${PORTAGE_TMPDIR}/portage/${PF}/image"``
``ROOT``      Path to the root directory. When not using ``${D}``,
              always prepend ``${ROOT}`` to the path.
============= =======================================================

Required Variables
------------------

The following variables must be defined by every ebuild.

====================== =======================================================
Variable               Purpose
====================== =======================================================
``DESCRIPTION``        A short (less than 80 characters) description of the
                       package's purpose.
``SRC_URI``            A list of source URIs for the package. Can contain
                       ``USE``-conditional parts, see `SRC_URI`_.
``HOMEPAGE``           Package's homepage
``KEYWORDS``           See `KEYWORDS`_ and `Keywording`_.
``SLOT``               The package's ``SLOT``. See `SLOT`_.
``LICENSE``            The package's licence, corresponding exactly (including
                       case) to a file in ``licenses/``. See `LICENSE`_.
``IUSE``               A list of all ``USE`` flags (excluding arch and auto
                       expand flags) used within the ebuild. See `IUSE`_.
====================== =======================================================

Optional Variables
------------------

Specifying the following variables is optional:

====================== =======================================================
Variable               Purpose
====================== =======================================================
``S``                  Path to the temporary build directory, used by
                       ``src_compile`` and ``src_install``. Default:
                       ``"${WORKDIR}/${P}"``. Ebuilds should **not** provide a
                       value for this ebuild if it is the default.
``DEPEND``             A list of the package's build dependencies.  See
                       `Dependencies`_.
``RDEPEND``            A list of the package's runtime dependencies. See
                       `Dependencies`_.
``PDEPEND``            A list of packages to be installed after the package
                       is merged. Should only be used where ``RDEPEND`` is not
                       possible. See `Dependencies`_.
``RESTRICT``           A space-delimited list of portage features to restrict.
                       Valid values are ``nostrip``, ``nomirror``, ``nouserpriv``
                       and ``fetch``. See `ebuild-5`_ for details.
``PROVIDE``            Any virtuals provided by this package, for example
                       ``"virtual/editor virtual/emacs"``.
====================== =======================================================

SLOT
----

When slots are not needed, use ``SLOT="0"``. Do **not** use ``SLOT=""``, as
this will disable slotting for this package.

KEYWORDS
--------

The only valid construct involving a ``*`` inside ``KEYWORDS`` is a ``-*``. Do
**not** use ``KEYWORDS="*"`` or ``KEYWORDS="~*"``.

See `Keywording`_ for how to handle this variable.

SRC_URI
-------

Conditional Sources
'''''''''''''''''''

Conditional source files based upon USE flags are allowed using the usual
``flag? ( )`` syntax. This is often useful for arch-specific code or for binary
packages -- downloading sparc binaries on ppc would be a waste of bandwidth.

.. CODESAMPLE variables-1.ebuild

When creating digests it may be necessary to have *all* SRC_URI components
downloaded. If you have ``FEATURES="cvs"`` set, portage should get this right,
although you may end up downloading more than necessary.

If a ``USE_EXPAND`` variable is used to control whether certain optional
components are installed, the correct thing to do if the variable is unset is
generally to install *all* available components.

.. CODESAMPLE variables-2.ebuild

IUSE
----

Note that the ``IUSE`` variable is cumulative, so there is no need to specify
USE flags used only within inherited eclasses within the ebuild's IUSE. Also
note that it's really really broken in portage versions before 2.0.51.

Arch USE flags (``sparc``, ``mips``, ``x86-fbsd`` and so on) should not be
listed. Neither should auto-expand flags (``linguas_en`` and so on).

LICENSE
-------

It is possible to specify multiple ``LICENSE`` entries, and entries which only
apply if a particular ``USE`` flag is set. The format is the same as for
``DEPEND``. See `GLEP 23`_ for details.

Version Formatting Issues
-------------------------

Often upstream's tarball versioning format doesn't quite follow Gentoo
conventions. Differences in how underscores and hyphens are used are
particularly common. For example, what Gentoo calls ``foo-1.2.3b`` may be
expecting a tarball named ``foo-1.2-3b.tar.bz2``. Rather than hard coding version
numbers, it is preferable to make a ``MY_PV`` variable and use that. The easy
way to do this, which should be used unless you are sure you know what you are
doing, is to use the ``versionator`` eclass:

.. CODESAMPLE variables-3.ebuild

This code has the advantage that it will carry on working even if upstream
switches to a format like ``foo-1.3-4.5.tar.bz2`` (yes, this really happens).

It is also possible to use bash substitution to achieve the same effect (this is
how versionator works internally), but this is complicated, error prone and hard
to read.

Some ebuilds use calls to ``sed``, ``awk`` and / or ``cut`` to do this. This
must *not* be done for any new code, and should be fixed to use either
versionator or bash substitution where possible. Global scope non-bash code is
highly discouraged.

The ``versionator`` eclass can also be used to extract particular components
from a version string. See `versionator.eclass-5`_ and the eclass source code
for further documentation and examples. A brief summary of the functions
follows.

==================================== ========================================
Function                             Purpose
==================================== ========================================
``get_all_version_components``       Split up a version string into its
                                     component parts.
``get_version_components``           Get important version components,
                                     excluding '.', '-' and '_'.
``get_major_version``                Get the major version.
``get_version_component_range``      Extract a range of subparts from a version
                                     string
``get_after_major_version``          Get everything after the major version.
``replace_version_separator``        Replace a particular version separator.
``replace_all_version_separators``   Replace all version separators.
``delete_version_separator``         Delete a version separator.
``delete_all_version_separators``    Delete all version separators.
==================================== ========================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
