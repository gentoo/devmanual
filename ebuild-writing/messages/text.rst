Messages
========

Sometimes it is necessary to display messages for the user. This can be for
errors, post-install help messages, pre-install warnings or simply to notify the
user of what's going on. It is considered good form to display a message
before any particularly long and silent task is carried out, for example (and it
also helps cut down on bogus "compiling foo froze!" bugs).

.. Note:: It is a policy violation to use any of these functions to display a line
    of characters (a banner header). The use of colours and special leading
    characters provided by these functions is sufficient to make a message stand
    out.

In all cases, assume that the user's terminal is no wider than 79 columns, and
that the ``einfo``, ``ewarn`` and ``eerror`` functions will occupy 4 columns
with their fancy leading markers.

Information Messages
--------------------

There are a number of functions available to assist here. The `echo` bash
internal is the simplest -- it simply displays its parameters as a message.

The ``einfo`` function can be used to display an informational message which is
meant to 'stand out'. On a colour terminal, the message provided will be
prefixed with a green star.

.. CODESAMPLE messages-1.ebuild

Warning Messages
----------------

The ``ewarn`` function is similar, but displays a yellow star. This should be
used for warning messages rather than information.

Error Messages
--------------

The ``eerror`` function displays a red star, and is used for displaying error
messages. It should almost always be followed by a ``die`` call. This function
is mainly used for displaying additional error details before bailing out.

Important Messages
------------------

For *really* important messages, ``eutils.eclass`` provides ``ebeep`` and
``epause``. The former will beep a number of times, and the latter will pause
for several seconds to allow the user to read any messages. Both can be disabled
by the user -- you must **not** attempt to override the user's preference in
this. ``ebeep`` takes an optional parameter specifying how many times to beep.
``epause`` takes an optional parameter (which **must** be an exact whole number)
specifying for how long it should sleep.

Do not abuse these functions -- better to save them for when things really are
important.

See `Message Functions Reference`_ for a full list of functions.

Good and Bad Messages
---------------------

Here is an example of a bad message:

.. CODESAMPLE messages-2.ebuild

* Displaying the same message repeatedly is excessive.
* The uppercase is excessive.
* The bad English looks unprofessional.
* The message will only confuse the end user and will not help them work out
  whether they have a problem and how to solve it if they do.

It would be better written as:

.. CODESAMPLE messages-3.ebuild

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

