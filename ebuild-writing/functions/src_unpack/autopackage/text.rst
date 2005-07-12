Autopackage
===========

If a package is only supplied in autopackage format, you must **not** add it to
the tree, nor go anywhere near it. If a package is supplied in autopackage
format and some other sane standard format (for example a source tarball), use
the other format only.

Autopackage packages are utterly unsuitable for Gentoo systems for a worryingly
large number of reasons:

* To even *unpack* the package, you must run arbitrary code supplied by an
  untrusted source.
* They install directly to the live filesystem.
* Their intrinsic dependency resolver is broken.
* They do not support the filesystem layout used by Gentoo.
* They do not support configuration protection.
* They can clobber arbitrary files on uninstall.
* The linking mechanism used is insufficiently flexible.
* The entire format is completely unportable and highly tied to x86 Linux
  systems.

Upstream are aware of these issues and have no desire to fix them -- indeed,
they pass off some of their most broken behaviour as 'features'.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

