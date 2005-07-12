grep -- Text Filtering
======================

The ``grep`` tool can be used to extract lines matching a given regular
expression from a file, or to check whether a given regular expression matches
any line in a file.

The usage is ``grep "pattern" files``. If no files are specified, text is read
from the standard input. The "pattern" is a standard basic regular expression,
as described in `IEEE1003.1-2004-9.3`_.

If the ``-E`` argument is supplied, ``pattern`` is treated as being an extended
regular expression as described in `IEEE1003.1-2004-9.4`_.

If the ``-F`` argument is supplied, ``pattern`` is treated as being a fixed
string rather than a regular expression.

By default, ``grep`` prints out matching lines from the input. If ``-q`` is
specified, no output is displayed. If ``-l`` (lowercase letter ell) is
specified, only the filenames of files which contain matching lines are
displayed.

The ``-v`` option can be used to select lines which do *not* match the pattern.

The ``-s`` option can be used to suppress messages about nonexistent or
unreadable files.

The return code can be used to test whether or not a match occurred. A return
code of ``0`` indicates that one or more matches occurred; a code of ``1``
indicates no matches.

See `IEEE1003.1-2004-grep`_ for details. The `grep-1`_ manual page on GNU systems
documents many non-portable additional features.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

