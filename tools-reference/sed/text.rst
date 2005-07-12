sed -- Stream Editor
====================

Sometimes it is better to use regular expressions to manipulate content rather
than patching sources. This can be used for small changes, especially those
which are likely to create patch conflicts across versions. The canonical way of
doing this is via ``sed``:

.. CODESAMPLE sed-1.ebuild

Another common example is appending a ``-gentoo-blah`` version string (some
upstreams like us to do this so that they can tell exactly which package they're
dealing with). Again, we can use ``sed``. Note that the ``${PR}`` variable will
be set to ``r0`` if we don't have a ``-r`` component in our version.

.. CODESAMPLE sed-2.ebuild

It is also possible to extract content from existing files to create new files
this way. Many ``app-vim`` ebuilds use this technique to extract documentation
from the plugin files and convert it to Vim help format.

.. CODESAMPLE sed-3.ebuild

A summary of the more common ways of using ``sed`` and a description of
commonly used address and token patterns follows. Note that some of these
constructs are specific to ``GNU sed 4`` -- on non-GNU userland archs, the
``sed`` command must be aliased to GNU sed. Also note that ``GNU sed 4`` is
guaranteed to be installed as part of ``system``. This was not always the case,
which is why some packages, particularly those which use ``sed -i``, have
``DEPEND`` s upon ``>=sys-apps/sed-4``.

Basic ``sed`` Invocation
------------------------

The basic form of a call is:

.. CODESAMPLE sed-4.ebuild

For cases where the input and output files are the same, the inplace option
should be used. This is done by passing ``-i`` as one of the option flags.

Usually ``sed`` prints out every line of the created content. To obtain only
explicitly printed lines, the ``-n`` flag should be used.

.. Note:: The term *pattern* refers to the description of text being matched.

Simple Text Substitution using ``sed``
---------------------------------------

The commonest form of ``sed`` is to replace all instances of ``"some text"``
with ``"different content"``. This is done as follows:

.. CODESAMPLE sed-5.ebuild

.. Note:: The ``/g`` flag is required to replace *all* occurrences. Without this
    flag, only the first match on each line is replaced.

.. Warning:: The above will replace ``"irksome texting"`` with
    ``"irkdifferent contenting"``, which may not be desired.

If the pattern or the replacement string contains the forward slash character,
it is usually easiest to use a different delimiter. Most punctuation characters
are allowed, although backslash and any form of brackets should be avoided.

.. CODESAMPLE sed-6.ebuild

Patterns can be made to match only at the start or end of a line by using the
``^`` and ``$`` metacharacters. A ``^`` means "match at the start of a line
only", and ``$`` means "match at the end of a line only". By using both in a
single statement, it is possible to match exact lines.

.. CODESAMPLE sed-7.ebuild

.. Note:: There is no need for a ``!g`` suffix here.

.. CODESAMPLE sed-8.ebuild

.. CODESAMPLE sed-9.ebuild

To ignore case in the pattern, add the ``/i`` flag.

.. CODESAMPLE sed-10.ebuild

.. Warning:: Case insensitive matching doesn't work correctly when backreferences
    are used.

Regular Expression Substitution using ``sed``
---------------------------------------------

It is also possible to do more complex matches with ``sed``. Some examples could
be:

* Match any three digits
* Match either "foo" or "bar"
* Match any of the letters "a", "e", "i", "o" or "u"

These types of pattern can be chained together, leading to things like "match
any vowel followed by two digits followed by either foo or bar".

To match any of a set of characters, a *character class* can be used. These come
in three forms.

* A backslash followed by a letter. ``\d``, for example, matches a single digit
  (any of 0, 1, 2, ... 9). ``\s`` matches a single whitespace character. A table
  of the more useful classes is provided later in this document.
* A group of characters inside square brackets. ``[aeiou]``, for example,
  matches any one of 'a', 'e', 'i', 'o' or 'u'. Ranges are allowed, such as
  ``[0-9A-Fa-fxX]``, which could be used to match any hexadecimal digit or the
  characters 'x' and 'X'. Inverted character classes, such as ``[^aeiou]``,
  match any single character *except* those listed.
* A POSIX character class is a special named group of characters that are
  locale-aware. For example, ``[[:alpha:]]`` matches any 'alphabet' character in
  the current locale. A table of the more useful classes is provided later in
  this document.

.. Note:: The regex ``a[^b]`` does **not** mean "match a, so long as it does not
    have a 'b' after it". It means "match a followed by exactly one character which
    is not a 'b'". This is important when one considers a line ending in the
    character 'a'.

.. Note:: At the time of writing, the ``sed`` documentation (`sed-1`_ and
    ``sed.info``) does not mention that POSIX character classes are supported.
    Consult `IEEE1003.1-2004-9.3`_ for full details of how these *should* work, and
    the ``sed`` source code for full details of how these *actually* work.

To match any one of multiple options, *alternation* can be used. The basic form
is ``first\|second\|third``.

To group items to avoid ambiguity, the ``\(parentheses\)`` construct may be
used. To match "iniquity" or "infinity", one could use ``in\(iqui\|fini\)ty``.

To optionally match an item, add a ``\?`` after it. For example, ``colou\?r``
matches both "colour" and "color". This can also be applied to character classes
and groups in parentheses, for example ``\(in\)\?finite\(ly\)\?``. Further atoms
are available for matching "one or more", "zero or more", "at least n", "between
n and m" and so on -- these are summarised later in this document.

There are also some special constructs which can be used in the replacement part
of a substitution command. To insert the contents of the pattern's first matched
bracket group, use ``\1``, for the second use ``\2`` and so on up to ``\9``. An
unescaped ampersand ``&`` character can be used to insert the entire contents of
the match. These and other replace atoms are summarised later in this document.

Addresses in ``sed``
--------------------

Many ``sed`` commands can be applied only to a certain line or range of lines.
This could be useful if one wishes to operate only on the first ten lines of a
document, for example.

The simplest form of address is a single positive integer. This will cause the
following command to be applied only to the line in question. Line numbering
starts from 1, but the address 0 can be useful when one wishes to insert text
*before* the first line. If the address 100 is used on a 50 line document, the
associated command will never be executed.

To match the last line in a document, the ``$`` address may be used.

To match any lines that match a given regular expression, the form
``/pattern/`` is allowed. This can be useful for finding a particular line and
then making certain changes to it -- sometimes it is simpler to handle this in
two stages rather than using one big scary ``s///`` command. When used in
ranges, it can be useful for finding all text between two given markers or
between a given marker and the end of the document.

To match a range of addresses, ``addr1,addr2`` can be used. Most address
constructs are allowed for both the start and the end addresses.

Addresses may be inverted with an exclamation mark. To match all lines *except*
the last, ``$!`` may be used.

Finally, if no address is given for a command, the command is applied to every
line in the input.

.. Note:: GNU ``sed`` does **not** support the ``%`` address forms found in some
    other implementations. It also doesn't support ``/addr/+offset``, that's an
    ``ex`` thing...

Other more complex options involving chaining addresses are available. These are
not discussed in this document.

Content Deletion using ``sed``
------------------------------

Lines may be deleted from a file using ``address d`` command. To delete the
third line of a file, one could use ``3d``, and to filter out all lines
containing "fred", ``/fred/d``.

.. Note:: sed -e ``/fred/d`` is *not* the same as ``s/.*fred.*//`` -- the former
    will delete the lines including the newline, whereas the latter will delete the
    lines' contents but not the newline.

Content Extraction using ``sed``
--------------------------------

When the ``-n`` option is passed to ``sed``, no output is printed by default.
The ``p`` command can be used to display content. For example, to print lines
containing "infra monkey", the command ``sed -n -e '/infra monkey/p'`` could be
used. Ranges may also be printed -- ``sed -n -e '/^START$/,/^END$/p'`` is
sometimes useful.

Inserting Content using ``sed``
-------------------------------

To insert text with sed use a ``address a`` or ``i`` command. The
``a`` command inserts on the line following the match while the ``i``
command inserts on the line before the match.

As usual, an address can be either a line number or a regular
expression: a line number command will only be executed once and a
regular expression insert/append will be executed for each match.

.. CODESAMPLE sed-11.ebuild

Note that you should use a match instead of a line number wherever
possible. This reduces problems if a line is added at the beginning of
the file, for example, causing your sed script to break.

Regular Expression Atoms in ``sed``
-----------------------------------

Basic Atoms
'''''''''''

================================== ==========================
Atom                               Purpose
================================== ==========================
``text``                           Literal text
``\( \)``                          Grouping
``\|``                             Alternation, a *or* b
``*`` ``\?`` ``\+`` ``\{\}``       Repeats, see below
``.``                              Any single character
``^``                              Start of line
``$``                              End of line
``[abc0-9]``                       Any one of
``[^abc0-9]``                      Any one character except
``[[:alpha:]]``                    POSIX character class, see below
``\1`` .. ``\9``                   Backreference
``\x`` (any special character)     Match character literally
``\x`` (normal characters)         Shortcut, see below
================================== ==========================

Character Class Shortcuts
'''''''''''''''''''''''''

========= ==========================
Atom      Description
========= ==========================
``\a``    "BEL" character
``\f``    "Form Feed" character
``\t``    "Tab" character
``\w``    "Word" (a letter, digit or underscore) character
``\W``    "Non-word" character
========= ==========================


POSIX Character Classes
'''''''''''''''''''''''

Read the source, it's the only place these're documented properly...

================= ==========================
Class             Description
================= ==========================
``[[:alpha:]]``   Alphabetic characters
``[[:upper:]]``   Uppercase alphabetics
``[[:lower:]]``   Lowercase alphabetics
``[[:digit:]]``   Digits
``[[:alnum:]]``   Alphabetic and numeric characters
``[[:xdigit:]]``  Digits allowed in a hexadecimal number
``[[:space:]]``   Whitespace characters
``[[:print:]]``   Printable characters
``[[:punct:]]``   Punctuation characters
``[[:graph:]]``   Non-blank characters
``[[:cntrl:]]``   Control characters
================= ==========================

Count Specifiers
''''''''''''''''

============= ==========================
Atom          Description
============= ==========================
``*``         Zero or more (greedy)
``\+``        One or more (greedy)
``\?``        Zero or one (greedy)
``\{N\}``     Exactly N
``\{N,M\}``   At least N and no more than M (greedy)
``\{N,\}``    At least N (greedy)
============= ==========================

Replacement Atoms in ``sed``
----------------------------

================== =============================
Atom               Description
================== =============================
``\1`` .. ``\9``   Captured ``\( \)`` contents
``&``              The entire matched text
``\L``             All subsequent characters are converted to lowercase
``\l``             The following character is converted to lowercase
``\U``             All subsequent characters are converted to uppercase
``\u``             The following character is converted to uppercase
``\E``             Cancel the most recent ``\L`` or ``\U``
================== =============================


Details of ``sed`` Match Mechanics
----------------------------------

GNU ``sed`` uses a traditional (non-POSIX) nondeterministic finite automaton with
extensions to support capturing to do its matching. This means that in all
cases, the match with the leftmost starting position will be favoured. Of all
the leftmost possible matches, favour will be given to leftmost alternation
options. Finally, all other things being equal favour will be given to the
longest of the leftmost counting options.

Most of this is in violation of one of the sillier POSIX rules, so it's best not
to rely upon it. It *is* safe to assume that ``sed`` will always pick the leftmost
match, and that it will match greedily with priority given to items earlier in
the pattern.

Notes on Performance with ``sed``
---------------------------------

.. Todo:: write this

Recommended Further Reading for Regular Expressions
---------------------------------------------------

The author recommends *Mastering Regular Expressions* by Jeffrey E. F. Friedl
for those who wish to learn more about regexes. This text is remarkably devoid
of phrases like "let ``t`` be a finite contiguous sequence such that ``t[n] ∈ ∑
∀ n``", and was *not* written by someone whose pay cheque depended upon them being
able to express simple concepts with pages upon pages of mathematical and Greek
symbols.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
