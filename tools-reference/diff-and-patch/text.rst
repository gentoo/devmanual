diff and patch -- File Differences
==================================

The ``diff`` tool is used to create patches (sometimes called diffs). A patch is
a program (computer science definition) which modifies text across one or more
files. Typically these are used for making changes to source code before it is
compiled.

The simplest invocation is ``diff -u oldfile newfile``, which will create a list
of differences in unified format between ``oldfile`` and ``newfile``. To operate
over directories instead, use ``diff -urN olddir newdir``.

.. Note:: ``cvs`` and ``svn`` provide ``cvs diff`` and ``svn diff`` respectively
    which may be more helpful.

For patches which go in the main tree, use unified (``-u``) format. This is
generally the best format to use when sending patches upstream too -- however,
occasionally you may be asked to provide context diffs, which are more portable
than unifieds (but don't handle conflicts as cleanly). In this case, use ``-c``
rather than ``-u``.

To apply a patch, use ``patch -pX < whatever.patch``, where ``X`` is a number
representing the number of path components which must be removed (typically this
is ``0`` or ``1``). Within ebuilds, use the ``epatch`` function instead -- see
`Patching with epatch`_.

The `diff-1`_ and `patch-1`_ manual pages provide more information.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


