``eutils.eclass`` Reference
===========================

The ``eutils`` eclass provides various useful functions. For full documentation,
see `eutils.eclass-5`_.

========================= ======================================================
Function                  Details
========================= ======================================================
``epause``                See `Message Functions Reference`_ and `Messages`_
``ebeep``                 See `Message Functions Reference`_ and `Messages`_
``gen_usr_ldscript``      Generate a linker script in ``/usr/lib`` for dynamic
                          libraries in ``/lib``
``draw_line``             Draw a line the same length as the arguments. Do not
                          use this for messages.
``epatch``                Apply a patch (see `eutils.eclass-5`_ and `Patching
                          with epatch`_).
``have_NPTL``             True if we are using NPTL (threads).
``get_number_of_jobs``    Try to get the number of jobs to use when compiling.
``emktemp``               Replacement for ``mktemp``.
``egetent``               Wrapper for ``getent``.
``enewuser``              See `Users and Groups`_.
``enewgroup``             See `Users and Groups`_.
``edos2unix``             Fix one or more files to use Unix line endings.
``make_desktop_entry``    Create a ``.desktop`` file. Args are the binary,
                          the name, the icon, the application type and the startup
                          path.
``make_session_desktop``  Create a GDM session file. Arguments are the title and
                          the command.
``domenu``                Install a menu file.
``doicon``                Install an icon file.
``check_license``         Display a licence for the user to accept. Argument is
                          the licence to use.
``cdrom_get_cds``         See `eutils.eclass-5`_.
``cdrom_load_next_cd``    See `eutils.eclass-5`_.
``strip-linguas``         Make sure ``LINGUAS`` contains only allowed values.
                          See `Linguas`_.
``built_with_use``        Check that a package was built with a given USE flag
                          enabled.
``dopamd``                Install a pam auth config file.
``newpamd``               Install a pam auth config file (two arg version).
========================= ======================================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


