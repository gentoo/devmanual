echo -- Print strings
=====================

The ``echo`` command can be used to print strings. The standard usage is ``echo
firstString secondString ...``. Also, it provides additional parameters for
formatting of the output.

Abuse of ``echo``
-----------------

If you find yourself about to use ``echo`` in an ebuild, eclass or initscript,
stop and reconsider. It is almost always unnecessary.

First of all, for printing messages in standard portage scripts, you can use
the ``einfo``, and ``eerror`` functions along with their corresponding
functions, ``einfon``, ``eerrorn``, etc, which are the same as the former,
but they won't print the trailing newline (``\n``).

All usage of the form ``echo ${somevar} | grep substring`` just to check if the
contents of the ``${somevar}`` variable contains ``substring``, or more
often, ``echo ${somevar} | command``, are deprecated and should be (and in most
cases, can be) used as less as possible: doing so involves for no reason an
additional shell session and a pipe. The "here strings" section describes
the preferred way of dealing with such cases.

Here Strings
------------

As of >=bash-2.05b, the so-called "here strings" have been
introduced. Using "here strings", you can pass contents of an
environment variable to the standard input of an application, using
``<<<word`` redirection: what actually happens is that bash
expands ``word`` and passes the result to the standard input.

A common example would be verifying if a variable ``${foo}`` contains
the ``bar`` substring with the following construct: ``grep bar <<<
${foo}``. This replaces the deprecated and more wasteful behaviour of
using ``echo ${foo} | grep bar``.

Standard usage of ``echo``
--------------------------

In standard calls, the ``echo`` command with no additional options, outputs the
arguments passed to the standard output, separated by whitespace and with a
trailing newline character (``\n``).

If one wants to exclude the trailing newline character, the ``-n`` option can be
passed, as in: ``echo -n "no trailing newline"``.

Special characters, like tabs (``\t``), newline characters (``\n``), carriage
return characters (``\r``) (i.e. for translating newlines from DOS format to
Unix format), and any other ASCII character given by its code value) can be
passed to the ``echo`` command with the ``-e`` option. For example, to output
three strings, each on different lines, in a single ``echo`` command, use:
``echo -e "first line\nsecond line\nthird line"``.

Other escape sequences and additional parameters for the ``echo`` command are
available in the man page.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
