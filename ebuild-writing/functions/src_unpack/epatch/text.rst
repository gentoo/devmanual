Patching with ``epatch``
========================

The canonical way of applying patches in ebuilds is to use ``epatch`` (from
``eutils.eclass``) inside ``src_unpack``. This function automatically handles
``-p`` levels, ``gunzip`` and so on as necessary.

Note that distributing modified tarballs rather than a vanilla tarball and
patches is *highly* discouraged.

Basic ``epatch`` Usage
----------------------

In its simplest form, ``epatch`` takes a single filename and applies that patch.
It will automatically ``die`` if the apply fails. The following is taken from
``app-misc/detox``:

.. CODESAMPLE epatch-1.ebuild

For larger patches, using ``mirror://gentoo/`` rather than ``files/`` is more
appropriate. In these situations, it is usually best to ``bzip2`` the patch in
question (as opposed to ``files/`` patches, which must **not** be compressed).
For example, from ``app-admin/showconsole``:

.. CODESAMPLE epatch-2.ebuild

Remember to add the patch to ``SRC_URI``.

CVS Keyword Lines and Patches
'''''''''''''''''''''''''''''

If your patch includes any changes to CVS ``$Id: $`` (or ``$Header: $``, or
``$Date: $``) lines, it cannot be distributed under ``files/``, since CVS will
clobber the patch when you commit. In these situations, either remove this hunk
of the patch manually, or mirror the file.

Multiple Patches with ``epatch``
--------------------------------

``epatch`` can also apply multiple patches (which can be selectively based upon
arch) from a single directory. This can be useful if upstream have a habit of
shipping severely broken releases that need dozens of patches.

A simple example:

.. CODESAMPLE epatch-3.ebuild

Here, one of the ``SRC_URI`` components is a tarball containing many patches
with file extension ``.patch``.

Variables which may be defined include:

======================== =====================================================
Variable                 Purpose
======================== =====================================================
``EPATCH_SOURCE``        Specifies the directory in which ``epatch`` looks for
                         patches.
``EPATCH_SUFFIX``        File extension for patches.
``EPATCH_OPTS``          Default options to ``patch``.
``EPATCH_EXCLUDE``       List of patches to exclude.
``EPATCH_FORCE``         Force epatch to apply patches even if they do not
                         follow the canonical naming form (set to ``yes``).
======================== =====================================================

Bulk patches should be named in the form ``??_${ARCH}_foo.${EPATCH_SUFFIX}``. If
they are not, ``EPATCH_FORCE="yes"`` must be set. To apply a patch on all archs,
use ``all`` for the ``${ARCH}`` part.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
