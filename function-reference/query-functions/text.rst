Query Functions Reference
=========================

The following functions, which are provided by ``ebuild.sh``, can be used to
query variables and similar state.

======================= ======================================================
Function                Details
======================= ======================================================
``use flagname``        Returns a true value if and only if ``flagname`` is
                        included in ``USE``
``useq flagname``       As ``use``, guaranteed to produce no output.
``usev flagname``       As ``use``, echoes ``flagname`` upon success.
``use_enable flag str`` Echoes either ``--enable-str`` or ``--disable-str``
                        depending upon ``useq flag``. If ``str`` is not
                        specified, uses ``flag`` instead.
``use_with flag str``   As ``use_enable``, but ``--with-`` or ``without-``.
``has flag string``     Returns true if ``flag`` is included in the flag list
                        ``string`` (example: ``if has ccache $FEATURES ; then``).
``hasq flag string``    As ``has``, guaranteed quiet.
``hasv flag string``    As ``has``, echoes ``flag`` on success.
``portageq``            Wrapper for ``portageq``
``best_version pkg``    Echoes the 'best' version of ``pkg`` which is currently
                        installed.
``has_version pkg``     True if ``pkg`` (can include version specifiers) is
                        installed.
======================= ======================================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


