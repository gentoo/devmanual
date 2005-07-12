Contributing to This Document
=============================

Contributions for this document are highly welcomed. Whether you've found a typo
or have written an entire new section, the best way to get in touch is to `send
an email to plasmaroo <mailto:plasmaroo@gentoo.org>`_.

The editor reserves the right to modify submissions as he sees fit. Any
substantial changes will of course be discussed with the submitter first --
unless explicitly requested, minor typo corrections and formatting fixes will
not be discussed.

This document is licenced under the `Creative Commons Attribution-ShareAlike
2.0 Licence <http://creativecommons.org/licenses/by-sa/2.0/>`_. If this is a
problem, don't submit anything.

If you're looking for something to do, the automatically generated `Todo List`_
might help.

This document is produced using some scary Makefile hacks from `Restructured
Text (RST) <http://docutils.sourceforge.net/rst.html>`_ files. To view the
source for a page, append ``text.rst`` to the URL or check the link in the page
footer. If you'd rather just work with plain text, that's fine too -- the
formatting can be done by someone else.

Quick Introduction to RST
-------------------------

Take a look at `the source for this page <text.rst>`_ for the basic structure of
an RST document.

RST Headings
''''''''''''

At the top of the page is a heading, which is underlined by a line of equals
signs. Within the page, normal headings use hyphens and subheadings use single
quotes.

.. Important:: These heading conventions *must* be followed. Although standard
  RST is more lenient regarding underline characters, the build system for this
  document makes some assumptions.

If subsubheadings are needed, use the caret character. Nothing actually uses
these yet -- it's probably better to restructure or split up your page if you
find yourself needing this.

.. Warning:: Heading names must be unique *throughout the entire document*. Try
  to pick long descriptive titles -- for example, 'Further Notes on Foo' rather
  than 'Further Notes'.

Currently, the colon character cannot be used in headings. If you really need to
use a colon, prod ciaranm and ask him to fix the build scripts.

Inline Markup
'''''''''''''

To make some *emphasised text*, surround it with ``*asterisks*``. To make some
**strongly emphasised text**, use ``**double asterisks**``. When typing ``code`` or
``filenames``, surround them with ````double backticks````. These characters can
be escaped using backslashes, like ``\`\`this\`\```.

To link to another section of the document, type the section name inside
backticks and append an underscore, ```like this`_``. You can link to any
section in *any* page of the document in this manner. There are also link
targets for GLEPs defined automatically for you, so ```GLEP 23`_`` will produce
a link to `GLEP 23`_.

To do an external hyperlink, use ```this format <http://example.com/>`_``.

Lists
'''''

To create a bullet list, use something like the following: ::

    + First
    + Second

      * Subitem for second
      * Another subitem for second

    + Third

.. Note:: You **must** leave a blank line before and after a list (and each
  sublevel in the list). A blank line between items is not necessary.

You can use ``+``, ``*``, ``.`` and ``-`` for bullet characters as you prefer,
so long as you consistently use the same marker for the same level.

To create a numbered list: ::

    1. First
    2. Second
    3. Third

Again, blank lines before and after the list are required.

To create a key / value list: ::

    First Key
        This text is the definition of first key.

    Second Key
        And this text is the definition of second key.

Code Blocks
'''''''''''

Large code blocks are started with a double colon. Any subsequent lines which
are indented are taken to be part of the code block. To end a code block, use an
unindented line. For example: ::

    Here is an example code block: ::

        This is code.
        This is still code.
        There's no need to escape *dodgy markup* here.

        This is still code.

    This is no longer code.

Tables
''''''

Tables in RST are tricky. Check `the main RST documentation
<http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#tables>`_ if
you're feeling up to it.

.. Todo:: Do we want to include some examples here?

Special Paragraphs
''''''''''''''''''

To create a note, use the ``note`` directive: ::

    .. Note:: This is a note. Note the two dots, the space, the directive
        type (in this case, Note), the lack of space and then the double
        colons. Also see how continuations onto new lines are indented.

There are also ``.. Warning::`` and ``.. Important::`` directives available.

.. Note:: The RST specification includes various others, but we don't have
    stylesheet rules defined for them. If there's anything you need from `the
    full list
    <http://docutils.sourceforge.net/docs/ref/rst/directives.html#specific-admonitions>`_,
    ask to have stylesheet support added.

The ``.. Todo::`` directive is a local hack that needs a patched docutils to
work. Feel free to use it, but be warned that it may not render correctly on
your system.

Build System Hacks
''''''''''''''''''

There're a few sometimes-useful substitutions which are performed by the build
system. For example: ::

    .. CODESAMPLE filename.blah

can be used to include a source file with generated syntax highlighting. It's
best to leave these to the editor -- they need some ``Makefile`` rules to back
them up.

To include a list of 'children' for a table of contents, use: ::

    .. CHILDLIST

Checking RST Text
-----------------

To check RST source, use: ::

    rst2html.py --report=2 --halt=2 < text.rst

You should ignore any warnings about missing link targets for GLEPs or link
references to headings in other documents -- these are handled automatically by
the build system. Similarly, ignore the lack of handling for ``.. Todo::`` and
the `build system hacks`_.

Style Guidelines
----------------

+ This document is in British English. Submissions in other kinds of English are
  welcome, but they may have their spelling corrected.
+ Third person should be used rather than first.
+ This is not a formal document. The writing style is intended to be
  professional but readable.
+ When using in-sentence hyphens as punctuation -- like this -- use a space,
  followed by two hyphens, followed by a space: ``--``. The build
  system will automatically turn this into a proper Unicode long dash.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
