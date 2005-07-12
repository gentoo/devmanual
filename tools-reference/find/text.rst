find -- Finding Files
=====================

The ``find`` utility can be used to search for and perform commands upon groups
of files matching a given set of criteria. The basic usage is ``find path rules``.

For portability purposes, **always** specify a path. Do not rely upon
``find`` defaulting to the current working directory if no path is provided.

Useful rules include:

================== ===========================================================
Rule               Effect
================== ===========================================================
``-name "blah"``   Only find files named ``blah``. The ``*`` and ``?`` wildcards
                   may be used.
``-type f``        Find only regular files, not directories.
``-type d``        Find only directories.
``-type l``        Find only symbolic links.
``-user foo``      Find only files belonging to user ``foo``. It is best to use
                   named users rather than numeric UIDs. In particular, ``root``
                   may not be UID 0 on some systems.
``-group foo``     Find only files belonging to group ``foo``. It is best to use
                   named groups rather than numeric GIDs.
================== ===========================================================

The ``-mindepth`` and ``-maxdepth`` are GNU extensions that should be avoided if
possible.

By default, ``find`` will echo a list of matching files to the standard output.
This can be used in a ``while`` loop:

.. CODESAMPLE find-1.ebuild

.. Warning:: The ``die`` construct will **not work** during the above loop. See
    `die and Subshells`_.

Or a ``for`` loop (for small numbers of files):

.. CODESAMPLE find-2.ebuild

.. Warning:: In both cases, files with weird characters or spaces in their names
    may cause serious problems.

As an alternative, ``find`` supports a ``-exec`` argument. It accepts a command
to run, terminated by a semicolon. Inside the command, the string ``{}`` is
replaced by the name of the current matched file. Be careful with escaping to
ensure that ``bash`` doesn't gobble up the special characters:

.. CODESAMPLE find-3.ebuild

See `find-1`_ and `IEEE1003.1-2004-find`_ for further details and examples.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

