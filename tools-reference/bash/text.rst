bash -- Standard Shell
======================

A thorough understanding of ``bash`` programming is vital when working with
ebuilds.

Bash Conditionals
-----------------

Basic Selection
'''''''''''''''

The basic conditional operator is the ``if`` statement:

.. CODESAMPLE bash-1.ebuild

Multiple Selection
''''''''''''''''''

Multiple pronged selection can be done using ``else`` and ``elif``:

.. CODESAMPLE bash-2.ebuild

.. Warning:: You **must** specify at least one statement inside each block. The
    following will **not** work:

.. CODESAMPLE bash-3.ebuild

If you really don't want to restructure the block, you can use a single colon
(``:``) on its own as a null statement.

.. CODESAMPLE bash-4.ebuild

Selection Tests
'''''''''''''''

To do comparisons or file attribute tests, ``[ ]`` or ``[[ ]]`` blocks are
needed.

.. CODESAMPLE bash-5.ebuild

Single versus Double Brackets in ``bash``
'''''''''''''''''''''''''''''''''''''''''

.. Important:: The ``[[ ]]`` form is generally safer than ``[ ]`` and should
    be used in all new code.

This is because ``[[ ]]`` is a bash syntax construct, whereas ``[ ]`` is a
program which happens to be implemented as an internal -- as such, cleaner
syntax is possible with the former. For a simple illustration, consider:

.. CODESAMPLE bash-6.ebuild

String Comparison in ``bash``
''''''''''''''''''''''''''''''

The general form of a string comparison is ``string1 operator string2``. The
following are available:

==================== =======================================================
Operator             Purpose
==================== =======================================================
``==`` (also ``=``)  String equality
``!=``               String inequality
``<``                String lexiographic comparison (before)
``>``                String lexiographic comparison (after)
``=~``               String regular expression match (**bash 3 only**, not
                     currently allowed in ebuilds)
==================== =======================================================

String Tests in ``bash``
''''''''''''''''''''''''

The general form of string tests is ``-operator "string"``. The following are
available:

==================== =========================================
Operator             Purpose
==================== =========================================
``-z "string"``      String has zero length
``-n "string"``      String has non-zero length
==================== =========================================

.. Note:: To check whether a variable is set and not blank, use ``-n "${BLAH}"``
    rather than ``-n $BLAH``. The latter will cause problems in some situations if
    the variable is unset.

Integer Comparison in ``bash``
''''''''''''''''''''''''''''''

The general form of integer comparisons is ``int1 -operator int2``. The
following are available:

==================== =========================================
Operator             Purpose
==================== =========================================
``-eq``              Integer equality
``-ne``              Integer inequality
``-lt``              Integer less than
``-le``              Integer less than or equal to
``-gt``              Integer greater than
``-ge``              Integer greater than or equal to
==================== =========================================

File Tests in ``bash``
''''''''''''''''''''''

The general form of a file test is ``-operator "filename"``. The following are
available (lifted from `bash-1`_):

==================== =========================================
Operator             Purpose
==================== =========================================
``-a file``          Exists (use ``-e`` instead)
``-b file``          Exists and is a block special file
``-c file``          Exists and is a character special file
``-d file``          Exists and is a directory
``-e file``          Exists
``-f file``          Exists and is a regular file
``-g file``          Exists and is set-group-id
``-h file``          Exists and is a symbolic link
``-k file``          Exists and its sticky bit is set
``-p file``          Exists and is a named pipe (FIFO)
``-r file``          Exists and is readable
``-s file``          Exists and has a size greater than zero
``-t fd``            Descriptor fd is open and refers to a terminal
``-u file``          Exists and its set-user-id bit is set
``-w file``          Exists and is writable
``-x file``          Exists and is executable
``-O file``          Exists and is owned by the effective user id
``-G file``          Exists and is owned by the effective group id
``-L file``          Exists and is a symbolic link
``-S file``          Exists and is a socket
``-N file``          Exists and has been modified since it was last read
==================== =========================================

File Comparison in ``bash``
'''''''''''''''''''''''''''

The general form of a file comparison is ``"file1" -operator "file2"``. The
following are available (lifted from `bash-1`_):

==================== =====================================================
Operator             Purpose
==================== =====================================================
``file1 -nt file2``  file1 is newer (according to modification date) than
                     file2, or if file1 exists and file2 does not.
``file1 -ot file2``  file1 is older than file2, or if file2 exists and
                     file1 does not.
``file1 -ef file2``  file1 and file2 refer to the same device and inode
                     numbers.
==================== =====================================================

Boolean Algebra in ``bash``
'''''''''''''''''''''''''''

There are constructs available for boolean algebra ('and', 'or' and 'not').
These are used *outside* of the ``[[ ]]`` blocks. For operator precedence, use
``( )``.

============================= ==================================
Construct                     Effect
============================= ==================================
``first || second``           first *or* second (short circuit)
``first && second``           first *and* second (short circuit)
``! condition``               *not* condition
============================= ==================================


.. Note:: These will also sometimes work *inside* ``[[ ]]`` constructs, and using
    ``!`` before a test is fairly common. ``[[ ! -foo ]] && bar`` is fine. However,
    there are catches -- ``[[ -f foo && bar ]]`` will **not** work properly, since
    commands cannot be run inside ``[[ ]]`` blocks.

Inside ``[ ]`` blocks, several ``-test`` style boolean operators are available.
These should be avoided in favour of ``[[ ]]`` and the above operators.

Bash Iterative Structures
-------------------------

There are a few simple iterative structures available from within ``bash``. The
most useful of these is a ``for`` loop. This can be used to perform the same
task upon multiple items.

.. CODESAMPLE bash-7.ebuild

There is a second form of the ``for`` loop which can be used for repeating an
event a given number of times.

.. CODESAMPLE bash-8.ebuild

There is also a ``while`` loop, although this is usually not useful within
ebuilds.

.. CODESAMPLE bash-9.ebuild

This is most commonly used to iterate over lines in a file:

.. CODESAMPLE bash-10.ebuild

See `die and Subshells`_ for an explanation of why ``while read < file`` should
be used over ``cat file | while read``.

Bash Variable Manipulation
--------------------------

There are a number of special ``${}`` constructs in ``bash`` which either
manipulate or return information based upon variables. These can be used instead
of expensive (or illegal, if we're in global scope) external calls to ``sed``
and friends.

``bash`` String Length
''''''''''''''''''''''

The ``${#somevar}`` construct can be used to obtain the length of a string
variable.

.. CODESAMPLE bash-11.ebuild

``bash`` Variable Default Values
''''''''''''''''''''''''''''''''

There are a number of ways of using a default value if a variable is unset or
zero length. The ``${var:-value}`` construct expands to the value of ``${var}``
if it is set and not null, or ``value`` otherwise. The ``${var:value}``
construct is similar, but checks only that the variable is set.

The ``${var:=value}`` and ``${var=value}`` forms will also assign ``value`` to
``var`` if ``var`` is unset (and not null for the ``:=`` form).

The ``${var:?message}`` form will display ``message`` to stderr and then exit if
``var`` is unset or null. This should generally not be used within ebuilds as it
does not use the ``die`` mechanism. There is a ``${var?message}`` form too.

The ``${var:+value}`` form expands to ``value`` if ``var`` is set and not null,
or a blank string otherwise. There is a ``${var+value}`` form.

``bash`` Substring Extraction
'''''''''''''''''''''''''''''

The ``${var:offset}`` and ``${var:offset:length}`` constructs can be used to
obtain a substring. Strings are zero-indexed. Both ``offset`` and ``length`` are
arithmetic expressions.

The first form with a positive offset returns a substring starting with the
character at ``offset`` and continuing to the end of a string. If the offset is
negative, the offset is taken relative to the *end* of the string.

.. Note:: For reasons which will not be discussed here, any negative value must be
    an *expression* which results in a negative value, rather than simply a negative
    value. The best way to handle this is to use ``${var:0-1}``. ``${var:-1}`` will
    **not** work.

The second form returns the first ``length`` characters of the value of
``${var}`` starting at ``offset``. If ``offset`` is negative, the offset is
taken from the *end* of the string. The ``length`` parameter *must not* be less
than zero. Again, negative ``offset`` values must be given as an expression.

``bash`` Command Substitution
'''''''''''''''''''''''''''''

The ``$(command )`` construct can be used to run a command and capture the
output (``stdout``) as a string.

.. Note:: The ```command``` construct also does this, but should be avoided in
    favour of ``$(command )`` for clarity, ease of reading and nesting purposes.

.. CODESAMPLE bash-12.ebuild


``bash`` String Replacements
''''''''''''''''''''''''''''

There are three basic string replacement forms available: ``${var#pattern}``,
``${var%pattern}`` and ``${var/pattern/replacement}``. The first two are used
for deleting content from the start and end of a string respectively. The third
is used to replace a match with different content.

The ``${var#pattern}`` form will return ``var`` with the shortest match of
``pattern`` at the start of the value of ``var`` deleted. If no match can be
made, the value of ``var`` is given. To delete the *longest* match at the start,
use ``${var##pattern}`` instead.

The ``${var%pattern}`` and ``${var%%pattern}`` forms are similar, but delete the
shortest and longest matches at the *end* of ``var`` respectively.

.. Note:: The terms *greedy* and *non-greedy* are sometimes used here (``%`` and
  ``#`` being the non-greedy forms). This is arguably incorrect, but the terms
  are fairly close.

The ``${var/pattern/replacement}`` construct expands to the value of ``var``
with the first match of ``pattern`` replaced with ``replacement``. To replace
*all* matches, ``${var//pattern/replacement}`` can be used.

.. Note:: `bash-1`_ incorrectly describes what will be matched. Of all the possible
    leftmost matches, the longest will be taken. Yes, really, the longest, even if
    it involves favouring later groups or later branches. This is **not** like
    ``perl`` or ``sed``. See `IEEE1003.1-2004-9.1`_ for details.

To match only if ``pattern`` occurs at the start of the value of ``var``, the
pattern should begin with a ``#`` character. To match only at the end, the
pattern should begin with a ``%``.

If ``replacement`` is null, matches are deleted and the ``/`` following
``pattern`` may be omitted.

The ``pattern`` may contain a number of special metacharacters for pattern
matching.

.. Todo:: tables of bash metachars

If the ``extglob`` shell option is enabled, a number of additional constructs
are available. These can be *extremely* useful sometimes.

.. Todo:: table of extra bash goodies

``bash`` Arithmetic Expansion
'''''''''''''''''''''''''''''

The ``$(( expression ))`` construct can be used for integer arithmetic
evaluation. ``expression`` is a C-like arithmetic expression. The following
operators are supported (the table is in order of precedence, highest first):

+-----------------------+-------------------------------------------------------+
| Operators             | Effect                                                |
+=======================+=======================================================+
| ``var++``, ``var--``  | Variable post-increment, post-decrement               |
+-----------------------+-------------------------------------------------------+
| ``++var``, ``--var``  | Variable pre-increment, pre-decrement                 |
+-----------------------+-------------------------------------------------------+
| ``-``, ``+``          | Unary minus and plus                                  |
+-----------------------+-------------------------------------------------------+
| ``!``, ``~``          | Logical negation, bitwise negation                    |
+-----------------------+-------------------------------------------------------+
| ``**``                | Exponentiation                                        |
+-----------------------+-------------------------------------------------------+
| ``*``, ``/``, ``%``   | Multiplication, division, remainder                   |
+-----------------------+-------------------------------------------------------+
| ``+``, ``-``          | Addition, subtraction                                 |
+-----------------------+-------------------------------------------------------+
| ``<<``, ``>>``        | Left, right bitwise shifts                            |
+-----------------------+-------------------------------------------------------+
| ``<=``, ``>=``,       | Comparison: less than or equal to, greater than or    |
| ``<``, ``>``          | equal to, strictly less than, strictly greater than   |
+-----------------------+-------------------------------------------------------+
| ``==``, ``!=``        | Equality, inequality                                  |
+-----------------------+-------------------------------------------------------+
| ``&``                 | Bitwise AND                                           |
+-----------------------+-------------------------------------------------------+
| ``^``                 | Bitwise exclusive OR                                  |
+-----------------------+-------------------------------------------------------+
| ``|``                 | Bitwise OR                                            |
+-----------------------+-------------------------------------------------------+
| ``&&``                | Logical AND                                           |
+-----------------------+-------------------------------------------------------+
| ``||``                | Logical OR                                            |
+-----------------------+-------------------------------------------------------+
| ``expr ? expr : expr``| Conditional operator                                  |
+-----------------------+-------------------------------------------------------+
| ``=``, ``*=``, ``/=``,| Assignment                                            |
| ``%=``, ``+=``,       |                                                       |
| ``-=``, ``<<=``,      |                                                       |
| ``>>=``, ``&=``,      |                                                       |
| ``^=``, ``|=``        |                                                       |
+-----------------------+-------------------------------------------------------+
| ``expr1 , expr2``     | Multiple statements                                   |
+-----------------------+-------------------------------------------------------+


.. Note:: There is no ``**=`` assignment operator.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
