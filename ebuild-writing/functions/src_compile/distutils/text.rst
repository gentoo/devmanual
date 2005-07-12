Distutils
=========

General overview
----------------

The python packaging system is known as "distutils", and the hallmark of a
python package using distutils is the presence of a ``setup.py`` file.
(One can think of the ``setup.py`` file as the python equivalent of a
Makefile.)  Although distutils is straightforward to use by directly
running the ``setup.py`` with the appropriate arguments, the distutils
eclass makes the process much simpler (and dramatically lowers the chance of
sandbox violations).  For example, for the ``dev-python/id3-py`` package the
body of the e-build (other than the header and URIs) could have been
written as:

.. CODESAMPLE distutils-1.ebuild

Any files listed in ``${DOCS}`` will be put in the docs directory when
installed.  Note that older versions of the distutils eclass used
``${mydoc}`` instead, but the preferred variable is ``DOCS``.

In practice, some tweaking is often required in the ``src_compile()`` or,
more commonly, in the ``src_install()`` steps, and the distutils eclass
provides ``distutils_src_compile()`` and ``distutils_src_install()``
convenience functions:

.. CODESAMPLE distutils-2.ebuild

Tkinter (Tk) support
--------------------

Until portage gains the long-requested ability to depend on USE
flags, ebuild authors who package graphical python programs will
probably need to check at emerge-time whether or not python was
compiled with support for Tkinter.  Since Tkinter requires Tk,
which requires X, default python builds do *not* include Tkinter.
It's easy enough to check:

.. CODESAMPLE distutils-3.ebuild

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en :
