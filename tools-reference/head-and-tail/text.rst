head and tail -- Line Extraction
================================

The ``head`` and ``tail`` utilities can be used to obtain only the first or last
parts of a file respectively. Both will read from the files named on the
commandline, or stdin if no files are provided.

The ``head`` utility takes a single argument, ``-n``, which must be followed by
an integer indicating the desired number of lines to be displayed.

.. Warning:: Use of the GNU ``-c`` option is unportable and should be avoided.

For full details, see `IEEE1003.1-2004-head`_. Note that `head-1`_ on GNU
systems describes many non-portable options.

The ``tail`` utility is similar, but takes lines from the *end* of the file. The
``-n`` argument specifies how many lines to display.

To specify "the last five lines", use ``tail -n5``. To specify "all but the
first five lines", use ``tail -n+5``.

For full details, see `IEEE1003.1-2004-tail`_. Note that `tail-1`_ on GNU
systems describes many non-portable options.

Chaining ``head`` or ``tail`` with ``sed``
------------------------------------------

Chaining ``head`` or ``tail`` with ``sed`` is usually unnecessary. Use of
addresses and early exit can do the same thing with a single ``sed`` call:

.. CODESAMPLE head-and-tail-1.ebuild

``tail -n X`` where X is larger than one is possible to do in pure
``sed`` but tricky. Using chained commands here is probably simplest.

Finally, to extract a single specific line, use ``sed`` instead:

.. CODESAMPLE head-and-tail-2.ebuild

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
