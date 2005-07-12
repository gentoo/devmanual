cut -- Column Extraction
========================

The ``cut`` tool can be used to extract specific columns from files which are
delimited by a particular character or by column numbers. It can be passed
filenames on the commandline; if none are specified, it reads from stdin.

The ``cut`` tool considers the first character in a line to have index ``1``.
The ``-c``, ``-f`` and ``-b`` switches take a parameter listing the desired
columns. This can be a single value, or a more complex list of values separated
by commas. Each value can be a single number, or two numbers separated by
hyphens representing ``low-high``. If ``low`` is unspecified, it is treated as
the first column. If ``high`` is unspecified, it is treated as being "up to the
last character (inclusive)".

To select particular characters from each line, use the ``-c`` switch. For
particular bytes (not the same as characters when using multibyte text), use
``-b``. To specify particular fields, use ``-f``.

When using ``-f``, the field delimiter can be specified using the ``-d`` switch.
The default value is the tab character. The ``-s`` switch instructs ``cut`` to
suppress lines which do not contain any instances of the delimiter -- by default
they are echoed intact.

For example, to extract the second, fourth and fifth columns in a
comma-delimited file, ignoring lines which contain no commas, one could use:

.. CODESAMPLE cut-1.ebuild

To chop the first character off stdin, one could use:

.. CODESAMPLE cut-2.ebuild

See `cut-1`_ and `IEEE1003.1-2004-cut`_ for full documentation.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

