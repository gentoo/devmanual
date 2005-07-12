ekeyword -- Keywording
======================

The ``ekeyword`` tool should be used to manipulate the ``KEYWORDS`` variable.
Using this tool will guarantee that you get the correct keyword ordering --
manual editing may screw this up. The usage is ``ekeyword changes ebuilds``.
Valid changes are in the form ``sparc`` (to mark stable), ``~sparc`` (to mark
unstable), ``-sparc`` (to mark unavailable) and ``^sparc`` (to remove the
``sparc`` keyword). The special ``all`` keyword is useful when doing version
bumps -- ``ekeyword ~all foo-1.23.ebuild`` will drop all currently present
keywords to unstable. See `ekeyword-1`_ for details.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

