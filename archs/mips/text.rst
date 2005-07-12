Arch Specific Notes -- MIPS
===========================

The MIPS port uses the ``mips`` keyword. It focuses upon commonly available
hardware -- mainly SGI and Cobalt systems -- although various embedded and
special purpose boards are also supported.

The ``mips`` keyword covers a huge range of architectures, CPUs and hardware,
from tiny embedded devices up to server class kit with many tens of CPUs.

.. Note:: Terminology
    ABI stands for "Application Binary Interface". It refers to issues like
    calling conventions (which registers are used for passing parameters when
    calling functions) and the size of data types. ISA stands for "Instruction
    Set Architecture", and refers to the instructions available and the number
    and types of registers for a given CPU.

MIPS ABIs
---------

The ``o32`` ABI was a wonderful invention by SGI that was good at the time, but
later turned out to be a little bit short-sighted and inefficient. The ``n32``
ABI corrects that problem by pretending to be 32 bit, whilst in reality being 64
bit. ``n64`` is another 64 bit ABI, this time not pretending to be 32 bit, which
is therefore large, fat and yet very powerful.

All of these ABIs can be both big and little endian, since MIPS CPUs come in
both flavours, although most hardware does not support both options.

All of these ABIs are popular amongst various applications domains. None of them
actually work correctly.

MIPS ISAs
---------

The most commonly seen MIPS ISAs are mips2, mips3, mips4, mips32 and mips64. If
you encounter a situation in which you need to know about the differences
between these, talk to the MIPS team.

Not Dropping ``CFLAGS`` on MIPS
-------------------------------

Because ``CFLAGS`` are sometimes used to specify ISA and ABI information, it is
vital that packages honour this setting. See `Not Filtering Variables`_.

Additional MIPS Keywording Requirements
---------------------------------------

.. Note:: This section is in addition to the guidelines in `Keywording`_. It
  discusses *additional* requirements for the MIPS architectures.

For a package to have the ``~mips`` keyword added, the following additional
items must generally hold:

* The package should work on both big and little endian systems, on both pure
  32 bit and pure 64 bit systems and on systems with differing kernel and
  userland ABIs.

It is generally expected that anyone who does keywording for MIPS should be on
the ``mips@`` alias.

Contacting the MIPS Team
-------------------------

The MIPS team can be contacted:

* Via Bugzilla bugs assigned to ``mips@``
* Via email to the ``mips@`` email alias
* Via email to the ``gentoo-mips`` mailing list
* Via the ``#gentoo-mips`` IRC channel on Freenode

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

