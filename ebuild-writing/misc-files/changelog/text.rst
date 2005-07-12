ChangeLog
=========

.. _echangelog: ..

The ``ChangeLog`` should be used to record all non-trivial changes to ebuilds,
*including keywording changes*. The `echangelog`_ tool should be used to create
``ChangeLog`` entries -- the format of a ``ChangeLog`` is now defined as
"whatever ``echangelog`` creates".

You should include references to any relevant bugs. The standard format for
doing this is via the phrase ``bug #20600`` -- this format (with the hash sign
included) is recognised via `packages.gentoo.org <http://packages.gentoo.org/>`_
and similar tools. When including user-submitted ebuilds or patches, you should
credit the user with their full name and email address (or whatever they use to
identify themselves on bugzilla -- some users prefer to be known only by a
nickname).

A typical ``ChangeLog`` snippet might look like the following:

.. CODESAMPLE changelog

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
