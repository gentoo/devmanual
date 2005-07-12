Emerge and Ebuild Relationships
===============================

.. figure:: diagram.png
    :alt: How emerge, ebuild and foo.ebuild interact

The ``emerge`` program is a high level wrapper for ``ebuild.sh`` that handles
dependency tracking, safe installs and uninstalls and so on. ``emerge`` calls
``ebuild.sh`` during the build process, which in turn handles the ebuild file
and any eclasses. The ``${D}`` to ``${ROOT}`` install is handled by ``emerge``.

.. Todo:: http://dev.gentoo.org/~g2boojum/portage.html

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


