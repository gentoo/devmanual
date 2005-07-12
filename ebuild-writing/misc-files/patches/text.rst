Patches
=======

There is no fixed rule for patch naming. The following are guidelines only.

Small patches (less than, say, a few KBytes) should be added to ``${FILESDIR}``.
If you anticipate having several patches, it often helps to create version
numbered subdirectories -- ``${FILESDIR}/${PV}/`` is conventional. Patches are
best named ``${P}-what-it-does.patch`` (or ``.diff``), where
``what-it-does`` is a two or three word description of what the patch is for. If
the patch is to fix a specific bug, it is often useful to add in the bug number
-- for example, ``vim-7.0-cron-vars-79981.patch``. If the patch is pulled from
upstream's CVS / SVN repository, it can help to include the revision number in
the patch name as a suffix to the version part --
``fluxbox-0.9.12-3860-menu-backups.patch``.

Patches included in ``${FILESDIR}`` should not be compressed.

Larger patches should be mirrored. When mirroring patches, choosing a name that
will not cause conflicts is important -- the ``${P}`` prefix is highly
recommended here. Mirrored patches are often compressed with ``bzip2``. Remember
to list these patches in ``SRC_URI``.

If a package requires many patches, even if they are individually small, it is
often best to create a patch tarball to avoid cluttering up the tree too much.

Patch Descriptions
------------------

It is possible to include a description with a patch. This is often helpful when
others come to work with your packages, or, indeed when you come back to take a
look at your own package a few months later. Good things to include in comments
are:

* What the patch actually does. Bug numbers are good here.
* Where the patch came from. Is it an upstream CVS/SVN pull, something from
  Bugzilla, something you wrote?
* Whether the patch has been sent upstream.

To include the description, simply insert it at the top of the patch file. The
``patch`` tool will ignore leading text until it finds something that looks like
it might be a 'start patching' instruction, so as long as each description line
starts with letters (rather than numbers, symbols or whitespace) there shouldn't
be a problem. Alternatively, prefix each description line with a hash (that's
``#``, or 'pound' to the USians) sign. It's also best to leave a single blank
line after the description and before the main patch.

Here's a simple example (``023_all_vim-6.3-apache-83565.patch``) from the
``vim`` patch tarball:

.. CODESAMPLE sample-patch.patch

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

