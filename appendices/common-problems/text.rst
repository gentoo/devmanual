Common Problems
===============

This page provides suggestions on how to handle various commonly seen errors
and QA notices.

Handling QA Notices
-------------------

The ``ebuild.sh`` part of portage includes a number of checks for common
problems. These can result in a 'QA Notice' message being displayed. You must
not rely upon portage always generating these messages -- they are not a
substitute for proper testing and QA by developers.

.. Note:: Some eclasses output messages in the same format. These are not
    covered here.

QA Notice -- USE Flag foo not in IUSE
'''''''''''''''''''''''''''''''''''''

With the exception of 'special' flags (the arch flags and ``USE_EXPAND``
variables), all ``USE`` flags used by a package must be included in ``IUSE``.
See `IUSE`_ and `USE Flags`_.

QA Notice -- foo in global scope
''''''''''''''''''''''''''''''''

This message occurs when various tools are inappropriately used in global scope.
Remember that no external code should be run globally. Depending upon the tool
in use, there are various alternatives:

``sed``, ``awk``, ``grep``, ``egrep``, ``cut`` etc
    Usually when any of the above are used in global scope, it is to manipulate
    a version or program name string. These should be avoided in favour of
    pure ``bash`` constructs. The ``versionator`` eclass is often of use here.
    See `Version Formatting Issues`_, `versionator.eclass-5`_ and `Bash Variable
    Manipulation`_.

``has_version``, ``best_version``, ``portageq``
    Calls to any of these globally indicates a serious problem. You must **not**
    have metadata varying based upon system-dependent information -- see `The
    Portage Cache`_. You should rewrite your ebuilds to correctly use
    dependencies.

``python``, ``perl`` etc
    Ebuilds are ``bash`` scripts. Offloading anything you don't know how to do
    in ``bash`` onto another language is not acceptable -- if nothing else,
    because not all users will always have a full system when ebuilds are
    sourced.

QA Notice -- foo is setXid, dynamically linked and using lazy bindings
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Dynamically linked setXid applications should not use lazy bindings when linking
for security reasons. If this message is shown, you have a couple of options:

* Modify the package's Makefile (or equivalent) to use ``-Wl,-z,now`` when
  linking. This solution is preferred.
* Use ``append-ldflags`` (see `Adding Additional Flags`_) to add ``-Wl,-z,now``.
  This will affect *all* binaries installed, not just the setXid ones.

QA Notice -- ECLASS foo inherited illegally
'''''''''''''''''''''''''''''''''''''''''''

All eclass inherits must be unconditional, or based purely upon static
machine-independent criteria (``PN`` and ``PV`` are most common here). See `The
Portage Cache`_.

You may see this warning in situations where there is not actually any illegal
inheritance occurring. Most commonly:

* When unmerging a package which was installed using an old portage version that
  did not record inheritance.
* When working with eclasses in an overlay with a stale cache. See `Overlay and
  Eclasses`_.
* When working with a stale portage cache.

You should manually check against the rules described in `The Portage Cache`_ if
you see this notice locally. If you see this notice when working with a pure
``emerge sync`` over ``rsync`` setup, it is probably a genuine issue.

.. Todo:: from vapier:
     TEXTREL's ... binary files which contain text relocations ... see
     'prepstrip' for a full description unsafe files ... basically files that
     are setid and writable by Other users i've added the following QA checks to
     portage HEAD (no idea when they'll hit a release): Insecure RUNPATHs ...
     binary files which have RUNPATH's encoded in them which are in +t
     directories Executable stacks ... binary files whose stack is marked with
     +x ... will bomb on amd64 for example

Handling ``repoman`` Messages
-----------------------------

.. Todo:: write me

Handling Access Violations
--------------------------

Portage uses a sandbox for certain phases of the build process. This prevents a
package from accidentally writing outside 'safe' locations. See `Sandbox`_ for
details.

If a package violates the sandbox, an error such as the following will be given
(assuming that the sandbox is enabled and working on the test system, which
should always be the case for developer boxes): ::

    --------------------------- ACCESS VIOLATION SUMMARY ---------------------------
    LOG FILE = "/tmp/sandbox-app-misc_-_breakme-1-31742.log"

    open_wr:   /big-fat-red-error
    --------------------------------------------------------------------------------

The ``open_wr`` means the package tried to open for write a file that is not
inside write-permitted areas. In this case, the file in question is
``/big-fat-red-error``.

Other error messages exist for read-restricted areas -- these are rarely used in
ebuilds.

Access violations most commonly occur during the install phase. See
``src_install`` and `Install Destinations`_ for discussion.

Sometimes problems can also occur with packages attempting to write to
``${HOME}``. To get around this, it is usually sufficient to trick the build
system into using a safer location. For example, the ``fluxbox`` menu generator
tries to work in ``${HOME}/.fluxbox`` -- to get around this, the following is
used:

.. CODESAMPLE violation-1.ebuild

In this situation, providing a fake home directory is all that is needed.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
