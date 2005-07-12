Quickstart Ebuild Guide
=======================

This page provides a *very* brief introduction to ebuild writing. It does not
attempt to cover many of the details or problems that will be encountered by
developers -- rather, it gives some trivial examples which may be of use when
trying to grasp the basic idea of how ebuilds work.

For proper coverage of all the ins and outs, see `Ebuild Writing`_. The `General
Concepts`_ chapter will also be of use.

Note that the examples used here, whilst based upon real tree ebuilds, have had
several parts chopped out, changed and simplified.

First Ebuild
------------

We'll start with an ebuild for the *Exuberant Ctags* utility, a source code
indexing tool. Here's a simplified ``dev-util/ctags/ctags-5.5.4.ebuild`` (you
can see real ebuilds in the main tree).

.. CODESAMPLE ex1.ebuild

Basic Format
''''''''''''

As you can see, ebuilds are just ``bash`` scripts that are executed within a
special environment.

At the top of the ebuild is a header block. This is present in all ebuilds.

Ebuilds are indented using tabs, with each tab representing four places. See
`Ebuild File Format`_.

Information Variables
'''''''''''''''''''''

Next, there are a series of variables. These tell portage various things about
the ebuild and package in question.

The ``DESCRIPTION`` variable is set to a *short* description of the package and
its purpose.

The ``HOMEPAGE`` is a link to the package's homepage (remember to
include the ``http://`` part).

The ``LICENSE`` is ``GPL-2`` (the GNU General
Public Licence version 2).

The ``SRC_URI`` tells portage the address to use for
downloading the source tarball. Here, ``mirror://sourceforge/`` is a special
notation meaning "any of the Sourceforge mirrors". The ``${P}`` is a read-only
variable set by portage which is the package's name and version -- in this case,
it would be ``ctags-5.5.4``.

The ``SLOT`` variable tells portage which slot this package installs to. If
you've not seen slots before, either just use ``"0"`` or read `Slotting`_.

The ``KEYWORDS`` variable is set to archs upon which this ebuild has been
tested. We use ``~`` keywords for newly written ebuilds -- packages are not
committed straight to stable, even if they seem to work. See `Keywording`_ for
details.

Build Functions
'''''''''''''''

Next, a function named ``src_compile``. Portage will call this function when it
wants to *compile* the package. The ``econf`` function is a wrapper for calling
``./configure``, and ``emake`` is a wrapper for ``make``. In both cases, the
common ``|| die "something went wrong"`` idiom is used -- this is to ensure that
if for some reason an error occurs, portage will stop rather than trying to
continue with the install.

The ``src_install`` function is called by portage when it wants to *install* the
package. A slight subtlety here -- rather than installing straight to the live
filesystem, we must install to a special location which is given by the ``${D}``
variable (portage sets this -- see `Install Destinations`_ and `Sandbox`_).
Again, we check for errors.

.. Note:: The canonical install method is ``make DESTDIR="${D}" install``. This
  will work with any properly written standard ``Makefile``. If this gives
  sandbox errors, try ``einstall`` instead. If this still fails, see
  `src_install`_ for how to do manual installs.

The ``dodoc`` and ``dohtml`` are helper functions for installing files into the
relevant part of ``/usr/share/doc``.

Ebuilds can define other functions (see `Ebuild Functions`_). In all cases,
portage provides a reasonable default implementation which quite often does the
'right thing'. There was no need to define a ``src_unpack`` function here, for
example -- this function is used to do any unpacking of tarballs or patching of
source files, but the default implementation does everything we need.

Ebuild with Dependencies
------------------------

In the ctags example, we didn't tell portage about any dependencies. As it
happens, that's ok, because ctags only needs a basic toolchain to compile and
run (see `Implicit System Dependency`_ for why we don't need to depend upon
those explicitly). However, life is rarely that simple.

Here's ``app-misc/detox/detox-1.1.1.ebuild``:

.. CODESAMPLE ex2.ebuild

Again, you can see the ebuild header and the various informational variables. In
``SRC_URI``, ``${PN}`` is used to get the package's name *without* the version
suffix (there are more of these variables -- see `Predefined Read-Only
Variables`_).

Again, we define ``src_compile`` and ``src_install`` functions.

The ``DEPEND`` and ``RDEPEND`` variables are how portage determines which
packages are needed to build and run the package. The ``DEPEND`` variable lists
compile-time dependencies, and the ``RDEPEND`` lists runtime dependencies. See
`Dependencies`_ for some more complex examples.

Ebuild with Patches
-------------------

Often we need to apply patches. This is done in the ``src_unpack`` function
using the ``epatch`` helper function. To use ``epatch`` one must first tell
portage that the ``eutils`` eclass (an eclass is like a library) is required --
this is done via ``inherit eutils`` at the top of the ebuild. Here's
``app-misc/detox/detox-1.1.0.ebuild``:

.. CODESAMPLE ex5.ebuild

Note the ``${FILESDIR}/${P}-destdir.patch`` -- this refers to
``detox-1.1.0-destdir.patch``, which lives in the ``files/`` subdirectory in the
portage tree. Larger patch files must go on the mirrors rather than in
``files/`` -- see `Basic epatch Usage`_.

Ebuild with USE Flags
---------------------

Now for some ``USE`` flags. Here's ``dev-libs/libiconv/libiconv-1.9.2.ebuild``,
a replacement iconv for ``libc`` implementations which don't have their own.

.. CODESAMPLE ex3.ebuild

Note the ``IUSE`` variable. This lists all (non-special) use flags that are used
by the ebuild. This is used for the ``emerge -pv`` output, amongst other things.

The package's ``./configure`` script takes the usual ``--enable-nls`` or
``--disable-nls`` argument. We use the ``use_enable`` utility function to
generate this automatically (see `Query Functions Reference`_).

Another more complicated example, this time based upon
``mail-client/sylpheed/sylpheed-1.0.4.ebuild``:

.. CODESAMPLE ex4.ebuild

Note the optional dependencies. Some of the ``use_enable`` lines use the
two-argument version -- this is helpful when the USE flag name does not exactly
match the ``./configure`` argument.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

