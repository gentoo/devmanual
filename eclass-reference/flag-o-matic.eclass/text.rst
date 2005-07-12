``flag-o-matic.eclass`` Reference
=================================

The ``flag-o-matic`` eclass provides functions for manipulating ``CFLAGS``,
``CXXFLAGS``, ``LDFLAGS`` and similar. See `Configuring Build Environment`_ for
examples.

========================================== ====================================
Function                                   Details
========================================== ====================================
``filter-flags <flags>``                   Removes any occurances of ``flags``
                                           in ``CFLAGS``, ``CXXFLAGS``
``append-flags <flags>``                   Appends ``flags`` to ``CFLAGS`` and
                                           ``CXXFLAGS``
``replace-flags <orig.flag> <new.flag>``   Replaces ``orig.flag`` (if present)
                                           with ``new.flag`` in ``CFLAGS``
                                           and ``CXXFLAGS``
``replace-cpu-flags <old.cpus> <new.cpu>`` Replaces ``-mtune=``, ``-mcpu=`` and
                                           ``-march=`` flags with any of
                                           ``old.cpus`` with ``new.cpu`` in
                                           ``CFLAGS`` and ``CXXFLAGS``
``is-flag <flag>``                         Tests whether ``flag`` is a valid
                                           flag with the current compiler
``strip-flags``                            Removes all non-safe flags from
                                           ``CFLAGS`` and ``CXXFLAGS``
``strip-unsupported-flags``                Removes any flags in ``CFLAGS`` and
                                           `CXXFLAGS`` which are not supported
                                           by the active compiler
``get-flag <flag>``                        Finds and echoes the value of the
                                           specified flag
``filter-mfpmath <math types>``            Removes the specified maths types
                                           from the fpmath specification (if
                                           present) in ``CFLAGS`` and ``CXXFLAGS``
``append-ldflags``                         Appends the specified flags to ``LDFLAGS``
``filter-ldflags <flags>``                 Remove the specified flags (if
                                           present) from ``LDFLAGS``
========================================== ====================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

