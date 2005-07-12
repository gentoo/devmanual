Users and Groups
================

If your ebuild requires a user or group to be added for a daemon, for example,
this should be performed via the functions available in ``eutils.eclass``.
Regardless of whether you are adding a group or a user, this should be performed
in the ``pkg_setup`` function and **not** somewhere else: pkg_setup is sandbox-safe,
is called before the compile process so a build that requires the user to exist will
have it, and is also called for both binary and source packages.

Adding Groups
-------------

To add a group, use the ``enewgroup`` function: ::

    enewgroup <name> [uid]

By default the next available group ID is selected. To set a specfic group ID,
pass it an extra argument to ``enewgroup``.

.. Note:: Group IDs should rarely be hardcoded. If this is the case, you should
    probably check first on gentoo-dev.

Adding Users
------------

To add a user, use the ``enewuser`` function: ::

    enewuser <user> [uid] [shell] [homedir] [groups] [params]

By default, both ``enewuser`` and ``enewgroup`` allocate the next available user
ID or group ID to the new user or group - if not, you explicitly have to specify
one.

Arguments for ``enewuser`` must be passed in the order as shown above: if you do
not want to specify a fixed user ID however but do want to set a specific shell,
for example, use ``-1`` for the ``uid`` parameter. The same applies for any other
parameter where you want to keep the default setting.

Groups for the ``groups`` argument should be separated by a comma (``,``) and
wrapped correctly, for example: ::

    enewuser frozd -1 -1 -1 "backup,frozd"

Finally, any data left over for the ``params`` argument is passed directly to
useradd.

.. Note:: User IDs should rarely be hardcoded. If this is the case, you should
    probably check first on gentoo-dev.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
