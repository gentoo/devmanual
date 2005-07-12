echangelog -- ChangeLog Generation
==================================

The ``echangelog`` tool should be used to generate ``ChangeLog`` entries. This
tool uses the ``ECHANGELOG_USER`` environment variable, which should be set in
the format ``"Your Name <luser@gentoo.org>"``. The changelog message should be
passed to ``echangelog`` on the commandline.

``echangelog`` should be called *after* any adds, removes or updates have been
made.

See `echangelog-1`_ for details.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

