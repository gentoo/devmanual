Profiles ``use.mask`` File
==========================

The ``use.mask`` file can be used to mark ``USE`` flags as unavailable on a
particular profile. This can be useful for various reasons:

* Masking hardware-specific feature flags. For example, ``mmx`` and ``sse`` are
  only available on x86, ``altivec`` is only available on ``ppc`` and ``vis`` is
  only available on sparc v9.

* Disabling unavailable soft dependencies. A simple hypothetical example -- say
  ``fooapp`` works on ``mips``, but has an optional dependency (controlled by
  the ``bar`` flag) upon ``libbar``, which doesn't work on ``mips``. Then by
  adding the ``bar`` flag to ``profiles/default-linux/mips/use.mask``,
  ``fooapp`` could be made available to ``mips`` users with the unresolvable
  dependency forcibly disabled.

Note that ``use.mask`` is a per-flag thing, not per package's use of a given
flag. This is one of the reasons that USE flags must have a specific well
defined purpose.

Updates to ``use.mask`` should be handled via the relevant arch team.

See `noblah USE Flags`_ for more discussion.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

