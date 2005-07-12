Error Handling
==============

Importance of Error Handling
----------------------------

Decent error handling is important because:

* Errors must be detected *before* portage tries to install a broken or
  incomplete package onto the live filesystem. If build failures aren't caught,
  a working package could be unmerged and replaced with nothing.

* When receiving bug reports, it is a lot easier to figure out what went wrong
  if you know exactly which function caused the error, rather than just knowing
  that, say, something somewhere in ``src_compile`` broke.

* Good error handling and notification can help cut down on the number of bug
  reports received for a package.

The ``die`` Function
--------------------

The ``die`` function should be used to indicate a fatal error and abort the
build. Its parameters should be the message to display.

Although ``die`` will work with no parameters, a short message should always be
provided to ease error identification. This is especially important when a
function can die in multiple places.

Some portage-provided functions will automatically die upon failure. Others will
not. It is safe to omit the ``|| die`` after a call to ``epatch``, but not
``econf`` or ``emake``.

Sometimes displaying additional error information beforehand can be useful. Use
``eerror`` to do this. See `Messages`_.

``die`` and Subshells
---------------------

.. Warning:: ``die`` **will not work in a subshell**.

The following code will not work as expected, since the ``die`` is inside a
subshell:

.. CODESAMPLE error-handling-1.ebuild

The correct way to rewrite this is to use an ``if`` block:

.. CODESAMPLE error-handling-2.ebuild

When using pipes, a subshell is introduced, so the following is unsafe:

.. CODESAMPLE error-handling-3.ebuild

Using input redirection (see `Abuse of cat`_) avoids this problem:

.. CODESAMPLE error-handling-4.ebuild

The ``assert`` Function and ``$PIPESTATUS``
-------------------------------------------

When using pipes, simple conditionals and tests upon ``$?`` will not correctly
detect errors occurring in anything except the final command in the chain. To get
around this, ``bash`` provides the ``$PIPESTATUS`` variable, and portage
provides the ``assert`` function to check this variable.

.. CODESAMPLE error-handling-5.ebuild

If you need the gory details of ``$PIPESTATUS``, see `bash-1`_. Most of the
time, ``assert`` is enough.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
