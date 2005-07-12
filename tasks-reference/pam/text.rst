Working with PAM
================

PAM (Pluggable Authentication Modules) is a mechanism which allows different
applications to authenticate using various specified parameters, using for
example a passwd/shadow file, a Kerberos server, an LDAP server or an a NT
Domain server (using Samba).

With PAM, a program just needs to require authentication for a given login class
(defined in a ``pam.d`` file), and PAM framework will take care of calling the
modules which will provide authentication.

There are different PAM implementations. Gentoo Linux, by default, uses the
Linux-PAM implementation which is installed via ``sys-libs/pam``; FreeBSD and
NetBSD (and hence Gentoo/FreeBSD) use OpenPAM, which is a minimal version.  The
different implementations can provide different authentication modules, and can
differ in some details of the configuration.

Structure of a ``pamd`` File
----------------------------

But let's see the structure of a ``pamd`` file. First of all, the ``pamd ``files
are placed in ``/etc/pam.d``, and they are structured as one statement per line.
The statement is composed of 3 or 4 tokens:

* The first token specifies the type of service for which the statement is done.
  There are four types:

  + *account*, which checks for validity of the user account.
  + *auth*, which verifies that the user is who is claim to be, using passwords
    or other ways such as biometric and smart-card devices.
  + *password*, which takes care of changing users' password.
  + *session*, which covers tasks such as checks for the user validity or
    mount/umount of home directories, executed both before starting and after
    closing the user session.

* The second token is the control that tells PAM how to behave with failures and success of the authentication for the module specified:
  
  + *requisite*, a failure results in the termination of the process.
  + *required*, a failure will lead in a failure for the service, but before
    this, all the other modules are being executed.
  + *sufficient*, a success in this module leads to a success in authentication
    if no *required* module failed before of it.
  + *optional*, in which case the failure or the success are ignored if this is
    not the only module present, in which case a success or a failure of it
    makes the authentication succeed or fail.

* The third token is the module to execute for that type of service; PAM modules
  are extensible and, as the name says, pluggable. The result is that there are
  a small number of default modules and some external optional modules which can
  be built against PAM implementation to define additional authentication
  methods.  Some documentation states that we need to specify the full path of
  the module, but this creates problems because not all the systems install the
  modules in the same place: Linux-PAM on Gentoo is generally set up to load
  them from ``/lib/security``, but for example on AMD64 this become
  ``/lib64/security``, and on OpenPAM they are just in ``/usr/lib(64)``. The
  result is that providing the full path will lead to non-working ``pamd``
  files, and the right way to handle this is just states the module name -- the
  PAM implementation will take care of finding the module.

* The last token, which can consist of multiple items, describe the parameters
  passed to the module. These are module-dependent.

As the number and the type of modules shipped with the implementation depends on
the implementations themselves (Linux-PAM provides a full working set of
modules, OpenPAM doesn't provide modules at all, and it's the operating system
which provides them, as FreeBSD or NetBSD do), there are just a few modules
which can be used directly in ``pamd`` files without the risk of providing a
non-working configuration file:

* ``pam_deny.so``, ``pam_permit.so`` -- they just report a failure or a success
* ``pam_rootok.so`` reports success if the user is root, else a failure
* ``pam_nologin.so`` checks for presence of /etc/nologin file with a reason for
  blocking user logins -- it's used for example when it's better to avoid users
  logging in on a compromised system
* ``pam_securetty.so`` checks that the login is done in a tty which is
  considered secure by a configuration file (depends on the implementation)
* ``pam_unix.so`` is the base module for Unix systems, it just checks the
  user/password pair with ``/etc/passwd`` and ``/etc/shadow``.

There are also other modules which can be used for more complex authentication
against a database (mysql or postgresql), against an LDAP directory or against
an NT domain (using samba). This is useful on thin or fat clients where the
users have an unique login for all the machines.  Another place where this is
useful is a cluster of servers which needs to authenticate against a single
source for some services, such as mail and ftp servers.

But for desktop systems, all the different services, such as mail servers, ftp
servers, ssh and so on, just need to authenticate in the same way the users logs
in to the system.

To achieve this, RedHat developed for Linux-PAM (which hadn't had a way to rely
on another authentication scheme) a ``pam_stack.so`` module which accepted as
parameter ``"login=<login service to use>"``, telling PAM to execute the auth
stack for the service stated.

Unfortunately that module relied upon internal data structures of Linux-PAM and
assumptions which aren't valid for other PAM implementations, so it is
completely non-portable. It is not used in all the implementations of Linux-PAM
(see for example MacOS X, which uses Linux-PAM but doesn't provide
``pam_stack.so``), and so it's not present on all Linux distributions.

A solution came when AltLinux developers added a new instruction for the control
token: *include*. That control token can be used on Linux-PAM 0.78 and on
OpenPAM to do the same as a ``required pam_stack.so``, replacing the module name
with the name of the login class to mimic.

In this way, instead of loading a module which in turn reloads pam, the option
is parsed directly by the PAM implementation which loads the other login class
and takes care of executing it, and the same syntax is valid on both Linux-PAM
and OpenPAM systems.

New packages (and new versions of old packages) should then use the ``include``
directive instead of ``pam_stack.so`` module, but to do that they need to depend
on a later version of ``sys-libs/pam`` or on ``sys-libs/openpam`` (note: openpam
is for now just on G/FreeBSD's project overlay) -- to resolve this,
``virtual/pam`` is set up to add the right dependency for the use of the include
directive.

Installing ``pamd`` Files
-------------------------

The right place for ``pamd`` files is ``/etc/pam.d``, but installing them by
hand checking for ``pam`` USE flag is tricky and doesn't follow the same path as
initd and confd files, so the solution is to use the ``pam`` eclass.

In the ``pam`` eclass there are functions which provide installation facilities
for ``pamd`` files (``dopamd`` and ``newpamd``, whose usage is the same as
similar ``do*`` and ``new*`` functions) and the ``/etc/security`` files
(``dopamsecurity`` and ``newpamsecurity``, which need the first argument to be
the subdirectory of ``/etc/security`` in which the files are to be installed).
Those groups of functions already takes care of verifying whether the ``pam``
USE flag is made optional for the package -- if this is the case, and the flag
is disabled, the ``pamd`` files are just skipped.

Many ``pamd`` files just uses one or more auth types from ``system-auth`` login class,
which is the base one which provides login facilities for most services on
common desktop systems.  Instead of adding a ``pamd`` file in ``${FILESDIR}``
for this, one can use the ``pamd_mimic_system`` function. This function takes a series
of parameters -- the first one is the name of the login class (the name of the
``pamd`` file in /etc/pam.d); the others are the auth types for which system-auth
needs to be used.

For example, a call like: ::

    pamd_mimic_system foo auth password

installs an ``/etc/pam.d/foo`` file which contains: ::

    auth		include		system-auth
    password	include		system-auth

which just uses ``system-auth`` login class.

Installing PAM Modules
----------------------

As PAM modules are looked for in different directories on different
implementations, which also depends on the libdir's name for ARCHs with more
than one ABI, usually is not possible to trust the default directory stated by
the module (always if the module state a default directory). The solution for
this is also in ``pam`` eclass. The function ``getpam_mod_dir`` returns the
correct directory to use for the current implementation/arch.

When the PAM mdoule doesn't provide a way to install the package by itself, such
as a ``Makefile`` or an installation script, there are also the ``dopammod`` and
``newpammod`` functions which takes care of install the module in the right
directory.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
