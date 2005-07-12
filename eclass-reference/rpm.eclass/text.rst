``rpm.eclass`` Reference
========================

The ``rpm`` eclass provides RPM unpacking services for packages that must
extract a source tarball from an RPM.

``rpm.eclass`` Variables
------------------------

======================== ======================================================
Variables                Details
======================== ======================================================
``USE_RPMOFFSET_ONLY``   ``rpm_unpack`` normally will use rpm2cpio over
                         rpmoffset if both exist.  If this variable is set to
                         1, ``rpm_unpack`` will use rpmoffset.
======================== ======================================================

``rpm.eclass`` Functions
------------------------

======================== ======================================================
Functions                Details
======================== ======================================================
``rpm_unpack`` *<file>*  Unpacks an RPM.  Behaves in the same fashion as
                         ``unpack`` (see `Unpacking Tarballs`_).
``rpm_src_unpack``       Default ``src_unpack`` that loops through ``${A}``
                         calling ``rpm_unpack`` for RPM's and ``unpack`` for
                         everything else.
======================== ======================================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
