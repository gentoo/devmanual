Arch Specific Notes -- SPARC
============================

The SPARC port uses the ``sparc`` keyword. It focusses mainly upon ``sun4u``
hardware (Sun UltraSparc systems with ``v9`` CPUs), although ``sun4m`` (Sun 32
bit hardware with ``v8`` and clones) is also sort-of supported.

SPARC Kernel and Userland ABIs
------------------------------

``v9`` systems use a pure 64 bit kernel and a pure 32 bit userland. This can
cause portability problems when working with low level software if the kernel
does not provide working 32 bit compatibility interfaces.

``v8`` systems use a pure 32 bit kernel and a pure 32 bit userland.

All supported SPARC systems are big endian.

Additional SPARC Keywording Requirements
----------------------------------------

.. Important:: This section is in addition to the guidelines in `Keywording`_.
  It discusses *additional* requirements for the SPARC architecture.

For a package to have the ``~sparc`` keyword added, the following additional
items must generally hold:

* The package must have been tested by an arch team member (or someone with
  permission from the arch team) *at least* on a ``v9`` system. Testing on
  ``v8`` is encouraged but not required.

It is generally expected that anyone who does keywording for SPARC should be on
the ``sparc@`` alias.

SPARC Instruction Set and Performance Notes
-------------------------------------------

There are three basic SPARC instruction set standards.

* ``v7`` is the original instruction set used in very old hardware. Gentoo does
  not ship ``v7`` capable stages, however a sufficiently crazy person could in
  theory run Gentoo on a ``v7`` machine.
* ``v8`` is an extension of ``v7`` with added support for hardware integer
  multiplication and division. Gentoo sparc32 (``sun4m``) stages are ``v8``.
* ``v9`` adds in 64 bit support and a large number of performance-enhancing
  features. Gentoo sparc64 (``sun4u``) stages are ``v9``.

In addition, individual CPU implementations have slight differences -- for
example, HyperSparc CPUs have relaxed requirements when it comes to scheduling
certain instructions. These are relatively minor differences.

If ``gcc`` is invoked without any ``-mcpu`` parameter, it will generate ``v7``
code. Depending upon the application, this can be anywhere up to five times
slower than ``v9`` code when running on an UltraSparc -- cryptographic and
graphics applications which make heavy use of integer multiplication and
division are especially badly hit. For this reason, the comments in `Not
Filtering Variables`_ are especially important on SPARC.

Contacting the SPARC Team
-------------------------

The SPARC team can be contacted:

* Via Bugzilla bugs assigned to ``sparc@``
* Via email to the ``sparc@`` email alias
* Via email to the ``gentoo-sparc`` mailing list
* Via the ``#gentoo-sparc`` IRC channel on Freenode

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

