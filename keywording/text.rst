Keywording
==========

.. Note:: Terminology
    The term 'package' refers to an entire directory, for example
    ``app-editors/vim`` -- it does *not* refer to a specific version. The terms
    'ebuild' or 'package version' are used when this meaning is intended. This
    distinction is important.

Every ebuild should specify a ``KEYWORDS`` variable. This variable is used to
indicate the suitability and stability of both the package and the ebuild on
each given arch (``sparc``, ``ppc``, ``x86-obsd``...).

.. Note:: The term 'arch' is used in this sense for historical reasons. As a result
    of `GLEP 22`_ and the various non-Linux ports, this is no longer a particularly
    accurate term.

A sample ``KEYWORDS`` entry might look like:

.. CODESAMPLE keywording-1.ebuild

The different levels of keyword are:

``arch`` (``x86``, ``ppc-macos``)
    Both the package version *and* the ebuild are widely tested, known to work
    and not have any serious issues on the indicated platform.

``~arch`` (``~x86``, ``~ppc-macos``)
    The package version and the ebuild are believed to work and do not have any
    known serious bugs, but more testing is required before the package version
    is considered suitable for ``arch``.

No keyword
    If a package has no keyword for a given arch, it means it is not known
    whether the package will work, or that insufficient testing has occurred for
    ``~arch``.

``-arch`` (``-x86``, ``-ppc-macos``)
    The package version will not work on the arch. This could be caused by badly
    written code (for example, non-64-bit or endian clean code), relying upon
    particular hardware (for example, a BIOS querying tool would not work on
    non-BIOS architectures) or binary only packages.

The ``-*`` keyword is special. It is used to indicate package versions which are
not worth trying to test on unlisted archs. For example, a binary-only package
which is only supported upstream on ``x86`` and ``ppc`` might use:

.. CODESAMPLE keywording-2.ebuild

This is different in implication from ``"x86 ppc"`` -- the former implies that
it will not work on other archs, whereas the latter implies that it has not been
tested.

Do **not** use the ``*`` or ``~*`` special keywords in ebuilds.

Equal Visibility Requirement
----------------------------

An ebuild **must not** depend upon any package that is of a lower keyword level
than itself. For example, if ``foo-1.2`` depends upon ``bar-1.2``, and
``bar-1.2`` is ``~x86``, then ``foo-1.2`` must **not** be marked stable on
``x86`` unless ``bar-1.2`` is also stabilised.

You may assume that if a user accepts ``~arch`` for a given arch then they also
accept ``arch``.

For optional dependencies, all *possible* dependencies must satisfy the above.
Note that certain ``USE`` flags can be forcibly disabled on a per-profile basis
-- talk to the arch teams if you require this. For either-or dependencies, *at
least one* of the options must be of equal or better visibility than the
package in question.

Hard Masks
----------

The ``package.mask`` file can be used to 'hard mask' individual or groups of
ebuilds. This should be used for testing ebuilds or beta releases of software,
and may also be used if a package has serious compatibility problems. Packages
which are not hard masked must **not** have a dependency upon hard masked
packages.

The only time it is acceptable for a user to see the ``Possibly a DEPEND
problem`` error message is if they have manually changed visibility levels for a
package (for example, through ``/etc/portage/``) and have missed a dependency.
**You should never commit a change which could cause this error to appear on a
user system**.

Keywording New Packages
-----------------------

.. Important:: New packages should be marked as ``~arch`` only upon
  architectures for which the committing developer has tested.

Do **not** assume that your package works on all architectures. Do **not**
assume that user submitted ebuilds will have correct ``KEYWORDS`` -- chances are
they just copied from somewhere else. Do **not** assume that upstream's
'supported architectures' list is correct. Do **not** assume that because your
code is written in Perl / Python / Java / whatever that it will run on other
archs (there is at least one case of a ``vim`` script which only worked on
``x86``).

Note that most (non-x86) archs expect you to be on the arch team and bugzilla
alias if you are committing packages with keywords for that arch, and may have
additional requirements of which you should be aware (on ``mips``, for example,
there are multiple ABIs and byte orders to consider -- a package working on your
``o32`` box may not work on ``o64`` or ``n32``). Contact the individual arch
teams for details.

Do **not** commit straight to ``arch``.

Keywording on Upgrades
----------------------

When upgrading, drop all existing keywords from ``arch`` to ``~arch``, and leave
any existing ``~arch`` keywords intact. This must be done even if you *think*
you're just making a trivial fix -- there have been several examples of the
stable tree getting broken this way.

Sometimes you may need to remove a keyword because of new unresolved
dependencies. If you do this, you **must** file a bug notifying the relevant
arch teams.

This also applies to revision bumps, not just to upstream version changes.

Moving from ``~arch`` to ``arch``
---------------------------------

With the exception of ``x86``, moving a package from ``~arch`` to ``arch`` is
done only by the relevant arch teams. If you have access to non-x86 but are not
on the arch teams, you may wish to make individual arrangements -- the arch
teams are happy for help, so long as they know what is going on.

For a package to move to stable, the following guidelines must be met:

* The package has spent a reasonable amount of time in ``~arch`` first. Thirty
  days is the usual figure, although this is clearly only a guideline. For
  critical packages, a much longer duration is expected. For small packages
  which have only minor changes between versions, a shorter period is sometimes
  appropriate.

* The package must not have any non-``arch`` dependencies.

* The package must not have any severe outstanding bugs or issues.

* The package must be widely tested.

* If the package is a library, it should be known not to break any package which
  depends upon it.

* (Excluding x86) the relevant arch team must agree to it.

For security fixes, the "reasonable amount of time" guideline may be relaxed.
See the `Vulnerability Treatment Policy
<http://www.gentoo.org/security/en/vulnerability-policy.xml>`_.

Removing Package Versions
-------------------------

When removing ebuild, ensure that you do not remove the most recent version at
any given keyword level on any profile. The aim here is:

* Never to force a downgrade. (Exception: occasionally you really do want to
  force a downgrade, for example if the newly committed ``foo-1.3`` turns out
  to be badly broken and that making everyone downgrade to ``foo-1.2`` is the
  better option. This is rare.)

* Do not break any existing dependencies.

If you would like a particular package version moved to stable on certain archs
so that you can tidy up, file a bug.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
