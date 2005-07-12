Hosted Projects
===============

The following guidelines have been proposed for hosted projects in an attempt to
prevent a repeat of the ``genkernel`` disaster.

Documentation Requirement
-------------------------

All hosted projects should have decent, up to date user and developer
documentation. This documentation must be available *before the first release*,
and not left as "something we'll do later (honest)".

Our documentation team are happy to help out with GuideXMLification, translation
etc. for the user documentation, but they *need* various things to do this:

+ Basic documentation to start with.
+ Basic information on the project or tool, such as:

  * The goals
  * The design specification
  * An FAQ

+ To be informed of any updates, in advance if at all possible -- this is to
  avoid having out of date recommendations in the documentation.

Developer documentation is generally best left in the hands of the project
maintainers.

Portability
-----------

Gentoo runs on a large number of architectures. This is one of our big
advantages over some other distributions. It is therefore important that any
tools are made with portability in mind, *even if you originally think that your
tool is only relevant for one arch*. It was this kind of assumption that meant
that ``genkernel`` had to be completely rewritten when it suddenly became
mandatory.

In practice, this means the following:

* Using a portable programming language -- no Java or C# for any Gentoo tools.
  Bash, C and Python are good, especially since everyone already has those
  installed.

* Not making assumptions about the hardware or architecture. This covers various
  things, depending upon the tool -- simple examples include:

    + Not assuming that you are running on a 32bit little endian system.
    + Not assuming that all computers have a VGA text console, or indeed any
      kind of graphics capability.
    + Not assuming that all computers use DOS disclabels.

* Not relying too strongly upon particular implementations of various tools,
  except where it has been agreed that we will always use a particular
  implementation of said tool (it is safe to use ``GNU sed`` extensions, for
  example, but *not* ``GNU find`` extensions).

Open / Free
-----------

All hosted projects should use an appropriate open / free / libre licence.
Typically this will be the GPL v2 for software, and the Creative Commons licence
for documentation. However, reasonable exceptions can be made -- sometimes it
makes more sense to use the LGPL or a \*BSD licence, and for application-specific
projects going with the application's licence may make more sense (the
``gentoo-syntax`` package for ``vim`` uses the ``vim`` licence, for example).

Accessible
----------

Projects should be accessible to users with disabilities. Simple examples of how
to go about this include:

+ Not relying solely upon colour to convey information.
+ Providing textual descriptions for any images.
+ Providing clear captions for dialogs, buttons, form fields and so on.

Good places to look for further hints include:

+ The `GNOME Accessibility Project <http://developer.gnome.org/projects/gap/>`_
+ The `W3C Web Accessibility Initiative Guidelines
  <http://www.w3.org/WAI/Resources/#gl>`_.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

