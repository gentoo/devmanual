Environment Files
=================

Some packages need to globally set an environment variable for all users. The
canonical way of doing this is via ``/etc/env.d``. All files in this directory
are sourced when generating user environment settings.

This directory should **only** be used for setting environment variables.

To install a file into this directory, use ``doenvd`` or ``newenvd`` (see
`Install Functions Reference`_). The format of the file should be a series of
lines in the form ``VARIABLE="the value"``.

There is further discussion in the `main handbook Environment Variables section
<http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=2&chap=5>`__.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

