cat -- File Concatenation
=========================

The ``cat`` command can be used to concatenate the contents of two or more
files. The usage is ``cat firstfile secondfile ...``.

Abuse of ``cat``
----------------

If you find yourself about to use ``cat`` in an ebuild, stop and reconsider. It
is almost always unnecessary.

All usages in the form ``cat somefile | somecommand`` are silly and should be
eschewed. The form ``somecommand < somefile`` does the same thing, and doesn't
involve an extra fork and a pipe. With many standard utilities the ``somecommand
somefile`` form will work as well.

Using ``foo=$(cat somefile)`` to place the contents of a file into the
variable ``foo`` is also unnecessary. The command ``foo=$(<somefile)`` works
just as well and doesn't require a fork. Similarly, ``cat file | xargs cmd`` and
``xargs cmd < file`` can be replaced by ``cmd $(<file)``.

Finally, ``cat foo > bar``, where ``foo`` is a single file, can usually be
replaced by ``cp -f foo bar``.

Here Documents
--------------

On the other hand, ``cat`` is exceptionally useful for so-called "here"
documents, such as the following example from ``sendmail-8.13.3 ebuild``

.. CODESAMPLE code-sample-1.ebuild

In this example ``cat`` is used inside ``src_install`` to create the
``${D}/etc/mail/trusted-users`` file.   Specifically, the new file will comprise
the lines between the ``cat`` line and the line with ``EOF`` in the ebuild.

The funny hyphen in ``<<-`` is a  >=bash-2.05 syntax that tells
``cat`` to strip leading tabs (please note that when you want to copy
the example, you have to replace the leading spaces with tabs), so
that, as Azarah puts it, "we won't have the ebuilds looking from space
effect".  For such small files as the example above, a set of here
documents is more elegant, and easier to maintain, than the equivalent
bunch of files floating about in ``${FILESDIR}`` would be. If for some
reason you need to preserve leading whitespace, then simply use ``<<``
instead of ``<<-`` to get the desired effect.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
