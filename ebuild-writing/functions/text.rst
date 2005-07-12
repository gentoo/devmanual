Ebuild Functions
================

When installing packages from source, the function call order is ``pkg_setup``,
``src_unpack``, ``src_compile``, ``src_test`` (optional, ``FEATURES="test"``),
``src_install``, ``pkg_preinst``, ``pkg_postinst``. When installing packages
from a binary, the function call order is ``pkg_setup``, ``pkg_preinst``,
``pkg_postinst``.

.. figure:: diagram.png
    :alt: ebuild function call order

The ``pkg_prerm`` and ``pkg_postrm`` functions are called when uninstalling a
package. The ``pkg_config`` function is used for any special package
configuration -- it is only run when explicitly requested by the user. The
``pkg_nofetch`` function is used when a ``RESTRICT="fetch"`` package needs to
obtain some ``SRC_URI`` components.

.. CHILDLIST

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

