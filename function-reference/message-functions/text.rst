Message Functions Reference
===========================

The following functions, which are provided by ``functions.sh``, can be used for
displaying informational messages.

====================== ======================================================
Function               Details
====================== ======================================================
``einfo``              Display an informational message.
``einfon``             Display an informational message with no trailing
                       newline.
``ewarn``              Display a warning message.
``eerror``             Display an error message.
``ebegin``             Display the message for the start of an action block.
``eend``               Display the end of an action block.
====================== ======================================================

The following are available from ``eutils.eclass``:

====================== ======================================================
Function               Details
====================== ======================================================
``epause``             Pause for the specified number (must be a positive
                       integer) of seconds. Defaults to a sane value.
``ebeep``              Beep the specified number (must be a positive integer) of
                       times. Defaults to a sane value.
====================== ======================================================

See `Messages`_ for a detailed discussion.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


