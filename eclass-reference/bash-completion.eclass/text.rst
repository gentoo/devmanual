``bash-completion.eclass`` Reference
====================================

The ``bash-completion`` eclass provides functions for installing contributed
bash-completion scripts. See `Completion Files`_ for how to write completion
scripts.

================================= ======================================================
Function                          Details
================================= ======================================================
``dobashcompletion``              Install a bash completion file if and only if
                                  the user has ``USE="bash-completion"``. If
                                  ``BASH_COMPLETION_NAME`` is set, this will be used for
                                  deciding the application name. Otherwise, the second
                                  argument will be used (if present), or failing that,
                                  ``${PN}``.
``bash-completion_pkg_postinst``  If the user has ``USE="bash-completion"``,
                                  displays a message explaining how to activate
                                  the completion for this package.
================================= ======================================================

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..



