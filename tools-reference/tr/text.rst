tr -- Character Translation
===========================

The ``tr`` command can be used to translate, squeeze and delete character
sequences. See `tr-1`_ and `IEEE1003.1-2004-tr`_ for the full specification.

.. Note:: ``tr``, unlike most other utilities, only reads from standard input
  and only writes to standard output. Therefore, you will have to use
  ``tr [options] < input > output``.

``tr`` operates in a number of modes, depending upon the invocation:

Deleting characters
    To delete all occurrences of certain characters, use ``tr -d asdf``.

Deleting repeated characters
    To replace repeated characters with a single character ('squeeze'), use
    ``tr -s asdf``.

Transliterating characters
    To replace all 'a' characters with '1', all 'b' with '2' and all 'c' with
    '3', use ``tr abc 123``.

Certain special forms are allowed for the arguments. ``a-z`` expands to all
characters from 'a' to 'z', ``\t`` represents a tab and so on. See the
documentation for a full list.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


