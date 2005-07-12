Dependencies
============

Automatic dependency resolution is one of the most useful features provided by
``emerge``.

Build Dependencies
------------------

The ``DEPEND`` ebuild variable should specify any dependencies which are
required to unpack, patch, compile or install the package (but see
`Implicit System Dependency`_ for exemptions).

Runtime Dependencies
--------------------

The ``RDEPEND`` ebuild variable should specify any dependencies which are
required at runtime. This includes libraries (when dynamically linked), any data
packages and (for interpreted languages) the relevant interpreter. If this
variable is not specified, it defaults to the value of ``DEPEND``.

Note that when installing from a binary package, only ``RDEPEND`` will be
checked. It is therefore necessary to include items even if they are also listed
in ``DEPEND``.

Items which are in ``RDEPEND`` but not ``DEPEND`` could *in theory* be merged
*after* the target package. Portage does not currently do this.

Post-Merge Dependencies
-----------------------

The ``PDEPEND`` variable specifies dependencies which must be merged *after* the
package. This is sometimes used for plugins which have a dependency upon the
package being merged. Generally ``PDEPEND`` should be avoided in favour of
``RDEPEND`` except where this will create circular dependency chains.

Implicit System Dependency
--------------------------

All packages have an implicit compile-time and runtime dependency upon the
entire ``system`` target. It is therefore not necessary, nor advisable, to
specify dependencies upon ``gcc``, ``libc`` and so on, except where specific
versions or packages (for example, ``glibc`` over ``uclibc``) are required.

However, packages which are included in the ``system`` target, or are
dependencies of ``system`` target packages, should generally include a complete
dependency list (excluding bootstrap packages). This makes ``emerge -e system``
possible when installing from a stage 1 or stage 2 tarball.

Basic Dependency Syntax
-----------------------

A basic ``*DEPEND`` specification might look like the following:

.. CODESAMPLE basic-depend-sample.ebuild

Each atom is the full category and name of a package. Atoms are separated by
arbitrary whitespace -- convention is to specify one atom per line for
readability purposes. When specifying names, the category part should be treated
as mandatory.

Version Dependencies
--------------------

Sometimes a particular version of a package is needed. Where this is known, it
should be specified. A simple example:

.. CODESAMPLE basic-depend-versions-sample.ebuild

This states that at least version 0.9.7d of ``openssl`` is required.

Version Specifiers
''''''''''''''''''

Available version specifiers are:

========================= ====================================================
Specifier                 Meaning
========================= ====================================================
``>=app-misc/foo-1.23``   Version 1.23 or later is required.
``>app-misc/foo-1.23``    A version strictly later than 1.23 is required.
``~app-misc/foo-1.23``    Version 1.23 (or any ``1.23-r*``) is required.
``=app-misc/foo-1.23``    Exactly version 1.23 is required. If at all possible,
                          use the ``~`` form to simplify revision bumps.
``<=app-misc/foo-1.23``   Version 1.23 or older is required.
``<app-misc/foo-1.23``    A version strictly before 1.23 is required.
========================= ====================================================

Ranged Dependencies
'''''''''''''''''''

To specify "version 2.x (not 1.x or 3.x)" of a package, it is necessary to use
the asterix postfix. This is most commonly seen in situations like:

.. CODESAMPLE ranged-depend-sample.ebuild

Note that the equals sign is mandatory, and that there is no dot before the
asterisk.

Blockers
''''''''

Sometimes two packages cannot be installed in parallel. This is handled by
blockers. A blocker is specified as follows:

.. CODESAMPLE block-sample.ebuild

Note that blockers are usually *runtime* rather than buildtime.

Specific versions can also be blocked:

.. CODESAMPLE block-version-sample.ebuild

Blockers can be optional based upon USE flags as per normal dependencies.

SLOT Dependencies
-----------------

It is not currently possible to depend upon a package in a particular ``SLOT``.
This is a shame.

USE-Conditional Dependencies
----------------------------

To depend upon a certain package if and only if a given ``USE`` flag is set:

.. CODESAMPLE use-depend-sample.ebuild

It is also possible to depend upon a certain package if a given ``USE`` flag is
*not* set:

.. CODESAMPLE use-depend-inv-sample.ebuild

This should **not** be used for disabling a certain ``USE`` flag on a given
architecture. In order to do this, the architecture should add the ``USE``
flag to their ``use.mask`` file in the ``profiles/default-linux/arch``
directory of the Portage tree.

This can be nested:

.. CODESAMPLE use-depend-nest-sample.ebuild

Virtual Dependencies
--------------------

To depend upon a virtual package, use ``virtual/whatever`` as the atom.

Currently, you must not use any kind of version specification with virtuals --
see `GLEP 37`_ for details and a proposed solution.

Any of Many Dependencies
------------------------

To depend on either ``foo`` or ``bar``:

.. CODESAMPLE use-depend-either-sample.ebuild

To depend on either ``foo`` or ``bar`` if the ``baz`` ``USE`` flag is set:

.. CODESAMPLE use-depend-either-use-sample.ebuild

Any of Many Versus USE
''''''''''''''''''''''

Say ``fnord`` can be built against either ``foo`` or ``bar``. Then a USE flag is
not necessary if and only if all of the following hold:

* ``fnord`` is merged on a system which has ``foo`` and not ``bar`` installed.
  ``foo`` is then unmerged, and ``bar`` is installed. ``fnord`` must continue to
  work correctly.

* A binary package of ``fnord`` made on a system with ``foo`` and not ``bar``
  can be taken and installed on a system with ``bar`` and not ``foo``.

Built with USE Dependencies
---------------------------

Currently it is impossible to depend upon "``foo`` built with the ``bar``
``USE`` flag enabled". This is a nuisance.

Legacy Inverse USE-Conditional Dependency Syntax
------------------------------------------------

When looking through old ebuild versions or the occasional user-submitted
ebuild, you may see a ``*DEPEND`` atom in the form:

.. CODESAMPLE use-depend-legacy-sample.ebuild

**This syntax is no longer permitted**. It is exactly equivalent to the
following, which should be used instead:

.. CODESAMPLE use-depend-nonlegacy-sample.ebuild

It is useful to recognise the legacy syntax and to know that it is no longer
valid.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
