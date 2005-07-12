Arch Specific Notes -- ALPHA
============================

The ALPHA port uses the ``alpha`` keyword. It focuses upon HP (formerly Compaq
(formerly DEC)) hardware. This covers from ``ev4`` (known as 21064) through
``ev7z`` (known as 21364a).

ALPHA Kernel and Userland ABIs
------------------------------

All ALPHA systems use a pure 64 bit kernel and a pure 64 bit userland.

All ALPHA systems support both little and big endian -- however, Linux only uses
little endian.

Additional ALPHA Keywording Requirements
----------------------------------------

It is generally expected that anyone who does keywording for ALPHA should be on
the ``alpha@`` alias. However the ALPHA Team is happy if maintainers keyword
their packages when they have access to ALPHA hardware, although the Team would
like to know about it.

ALPHA Instruction Set and Performance Notes
-------------------------------------------

There are six basic ALPHA instructions set standards:

* ``ev4`` or ``ev45``. The ``ev4`` was the first ALPHA processor of the Alpha
  family. It featured one integer pipeline and one floating-point pipeline.
  The ``ev45`` is a modified ``ev4`` with double both Data and Instruction cache
  (D-Cache and I-Cache respectively); it also featured a division optimization.
* ``ev5`` is an evolution of the ``ev45``. The number of pipelines was doubled
  and the floating-point pipelines run in 9 stages rather than in 10. The
  ``ev5`` supports 3 cache levels.
* ``ev56`` added the BWX extension to load/store data in 8 or 16 bit quanta.
* ``pca56`` added a new set, MVI (Motion Video Instructions), aimed to
  accelerate video and audio calculations.
* ``ev6`` supports all extensions supported by the ``pca56`` and a new set, FIX,
  meant to move data between integer and floating-point registers and for square
  root.
* ``ev67`` is an evolution of the ``ev6``, in addition it supports a new set.
  CIX adds instructions for counting and finding bits.

When no ``-mcpu`` option is passed to ``gcc`` it defaults to the processor on
which the compiler was built.

The ``-mieee`` flag **should** always be used unless you have a deep knowledge
of the ALPHA architecture, so the comments on `Not Filtering Variables`_ are
really important on ALPHA.

Notes on ALPHA and PIC
----------------------

General `Position Independent Code`_ policy also applies to ALPHA. In fact,
ALPHA systems complain loudly if you try to link PIC and non-PIC code. Usually
this results in errors during the compilation aborting emerge.

Contacting the ALPHA Team
-------------------------

The ALPHA team can be contacted:

* Via Bugzilla bugs assigned to ``alpha@``
* Via email to the ``alpha@`` email alias
* Via email to the ``gentoo-alpha`` mailing list
* Via the ``#gentoo-alpha`` IRC channel on Freenode

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
