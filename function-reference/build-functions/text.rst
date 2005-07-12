Build Functions Reference
=========================

The following functions, which are all provided by ``ebuild.sh``, are useful
during the unpack and compile stages.

====================== ======================================================
Function               Details
====================== ======================================================
``unpack archives``    Unpack the specified archives.
``econf args``         Wrapper for ``./configure``. Passes on all ``args``.
``emake args``         Wrapper for ``make``. Passes on all ``args``.
``einstall args``      Wrapper for ``make install``, only to be used if ``make
                       DESTDIR="${D}"`` is unsuitable.
====================== ======================================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

