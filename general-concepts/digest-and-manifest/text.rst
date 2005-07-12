Digest and Manifest
===================

In the tree, every package has a ``Manifest`` file. This file lives in the same
directory as the ebuilds for the package. The ``Manifest`` file contains digests
(currently MD5) and file size data for every file in the directory and any
subdirectories. This is used to verify integrity.

The ``Manifest`` may be digitally signed.

Inside the ``files/`` subdirectory, there is exactly one ``digest`` file per
ebuild. Each file contains a digest (currently MD5) and a file size for every
file listed in ``SRC_URI`` for the ebuild. This is used to verify downloads and
to catch any changed source files.

When generating digests, it is necessary to include *all* of the files which
*could* be downloaded (``SRC_URI`` can contain conditional entries). Portage
will do this automatically if ``cvs`` is included in ``FEATURES``.

To generate digests and ``Manifest``, use ``ebuild foo.ebuild digest``. When
committing, the ``Manifest`` file must be regenerated to handle any CVS keyword
expansion changes -- ``repoman`` will do this automatically.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
