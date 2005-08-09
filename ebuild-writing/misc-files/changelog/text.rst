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

If you are changing keywords, make sure you clearly state what keywords you add
or remove. "Marked stable" is a nuisance for architecture teams, even if there
was only one keyword in the ebuild at the time. "Stable on all archs" isn't
generally any better   (and should you really be stabling on all archs?) -- do
you mean "all", or "all the ones that are currently keyworded"? A list like
"x86 sparc mips" is much more useful.

A typical ``ChangeLog`` snippet might look like the following:

.. CODESAMPLE changelog

Writing correct ChangeLog messages
----------------------------------

.. Note:: It is *very* important that your ``cvs commit`` messages are
   also informative to aid the QA team or architecture teams as well
   as other developers if they are trying to troubleshoot issues which
   are known to not have occured in previous versions of ebuilds, for
   example. If your ChangeLog message is concise there is usually
   nothing wrong with using it as the ``cvs commit`` message.

Your message should explain what specifically you changed and, if
relevant, why. You don't need to write an essay or even a complete
sentence (ChangeLog messages, however, *are* required to be in
'proper' English so no ``fixed that bug, kthx Bob`` messages -- please
do use punctuation), so long as it is easily understandable and
(preferably) greppable. Examples, all of which are based upon real
messages:

* **BAD**: Changed keywords
* *GOOD*: Added ~x86 keyword

* **BAD**: Stable
* *GOOD*: Stable on x86, sparc, mips

* **BAD**: Fix stuff
* *GOOD*: Fix USE=foo logic error

* **BAD**: .
* *GOOD*: Purge old ebuilds

* **BAD**: Who the fuck reads these anyway? (**Editor's note**: No, seriously, this is a genuine example. Do *not* do this...)
* *GOOD*: Version bump to 0.5.1.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
