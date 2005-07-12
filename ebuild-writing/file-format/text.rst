Ebuild File Format
==================

An ebuild is a ``bash`` script which is executed within a special environment. Files
should be simple text files with a ``.ebuild`` extension.

File Naming Rules
-----------------

An ebuild should be named in the form ``name-version.ebuild``.

The name section should contain only lowercase non-accented letters, the digits
0-9, hyphens, underscores and plus characters. Uppercase characters are strongly
discouraged, but technically valid.

.. Note:: This is the same as `IEEE1003.1-2004-3.276`_, with the addition of the plus
    character to keep gtk+ and friends happy.

The version section is more complicated. It consists of one or more numbers
separated by full stop (or period, or dot, or decimal point) characters (eg
``1.2.3``, ``20050108``). The final number may have a single letter following it
(eg ``1.2b``). This letter should not be used to indicate 'beta' status --
portage treats ``1.2b`` as being a later version than ``1.2`` or ``1.2a``.

There can be a suffix to version indicating the kind of release. In the following table, what portage considers to be the 'lowest' version comes first.

=============== ===========================
Suffix          Meaning
=============== ===========================
``_alpha``      Alpha release (earliest)
``_beta``       Beta release
``_pre``        Pre release
``_rc``         Release candidate
(no suffix)     Normal release
``_p``          Patch level
=============== ===========================

Any of these suffixes may be followed by a non-zero positive integer.

Finally, version may have a Gentoo revision number in the form ``-r1``. The initial
Gentoo version should have no revision suffix, the first revision should be
``-r1``, the second ``-r2`` and so on. See `Ebuild Revisions`_.

Overall, this gives us a filename like ``libfoo-1.2.5b_pre5-r2.ebuild``.

Ebuild Header
-------------

All ebuilds committed to the tree should have a three line header immediately at
the start indicating copyright. This must be an exact copy of the contents of
``$(portageq portdir)/header.txt``. Ensure that the ``$Header: $`` line is not
modified manually -- CVS will handle this line specially.

.. CODESAMPLE header-sample.ebuild

Indenting and Whitespace
------------------------

Indenting in ebuilds must be done with tabs, one tab per indent level. Each tab
represents four spaces. Tabs should only be used for indenting, never inside
strings.

Avoid trailing whitespace: repoman will warn you about this if your
ebuild contains trailing or leading whitespace (whitespace instead of
tabs for indentation) when you commit.

Where possible, try to keep lines no wider than 80 positions. A 'position' is
generally the same as a character -- tabs are four positions wide, and multibyte
characters are just one position wide.

Character Set
-------------

All ebuilds (and eclasses, metadata files and ChangeLogs) must use the UTF-8
character set. See `GLEP 31`_ for details, and `glep31check`_ for an easy way of
checking for validity.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
