RPM Sources
===========

If a package is supplied as an .rpm file, you should:

.. CODESAMPLE rpm-1.ebuild


If you don't need to do anything in the unpack phase, then you are finished as
the ``rpm.eclass`` exports a default ``src_unpack`` that will unpack the rpm
files.

If you do need to apply patches then override ``src_unpack`` in a manner such
as:

.. CODESAMPLE rpm-2.ebuild

.. Note:: ``${A}`` can contain non-rpm files since the rpm eclass will call
   the normal ``unpack`` function for files that are not in the rpm format.


Notes on Using ``rpm.eclass``
-----------------------------

There are two ways to unpack a rpm file -- using the ``rpmoffset`` program from
``rpm2targz`` and ``cpio``, or by using ``rpm2cpio`` from ``app-arch/rpm``.
Normally, for unpacking an rpm file, installing the entire rpm application is
overkill. Because of this, the eclass will only use ``rpm2cpio`` if ``rpm`` is
already installed on the system.  If you want to force the eclass to only use
the rpm offset method, set ``USE_RPMOFFSET_ONLY=1``.

Another issue that might arise is that ``rpmoffset`` and ``cpio`` are not able
to unpack the rpm file correctly.  If this occurs, then you need to add
``app-arch/rpm`` to the ``DEPEND`` variable so that ``rpm2cpio`` will be used
instead.

Example RPM Handling
--------------------

Here is an ebuild snippet that is based upon the fetchmail source rpm from SuSE
9.2. The ebuild snippet is complete enough to work with the ``ebuild unpack``
command.  The ebuild will download the source file from the OSU SuSE mirror,
unpack the file and apply the included patches. The filename should be
``suse-fetchmail-6.2.5.54.1.ebuild``.

.. CODESAMPLE rpm-3.ebuild

Completion of the ebuild left as exercise to the reader.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
