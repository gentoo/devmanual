The Portage Tree
================

The basic layout of the portage tree is as follows:

* Categories, for example ``app-editors``, ``sys-apps``

  + Category metadata, for example ``app-admin/metadata.xml``

  + Package directories for example ``app-editors/vim``

    - Package metadata, for example ``app-editors/vim/metadata.xml``

    - Package changelog, for example ``app-editors/vim/ChangeLog``

    - Package Manifest, for example ``app-editors/vim/Manifest``

    - Ebuilds, for example ``app-editors/vim/vim-6.3.068.ebuild``,
      ``app-editors/vim/vim-7.0_alpha20050326.ebuild``

    - Package files directory, for example ``app-editors/vim/files``

      * Digest files, for example
        ``app-editors/vim/files/digest-vim-6.3.068``,
        ``app-editors/vim/files/digest-vim-7.0_alpha20050326``

      * Small patches and other miscellaneous files, for example
        ``app-editors/vim/files/vim-completion``

* Eclasses directory, ``eclass/``

* Licenses directory, ``licenses/``

* Profiles directory, ``profiles/``

  + Various control and documentation files, for example ``categories``,
    ``info_pkgs``, ``info_vars``, ``package.mask``, ``use.desc``

  + Updates directory, ``profiles/updates/``

    - Updates files, for example ``profiles/updates/1Q-2005``

  + Main profile cascade

* Scripts directory, ``scripts/``

* Distfiles directory, ``distfiles/``. This is not included in the main CVS
  tree, but it will be found on most user systems.

* Packages directory, ``packages``. Again, this is found on user systems but not
  in the main CVS tree.

What Belongs in the Tree?
-------------------------

Things that do **not** belong in the tree:

* Large patches
* Non-text files
* Photos of teletubbies
* Files whose name starts with a dot

Software-wise, in general all of the following should be met in order for a
package to be included in the tree:

Active, Cooperative Upstream
    If a package is undeveloped or unmaintained upstream, it can be extremely
    difficult to get problems fixed. If a package does not have an active
    upstream, the developers who add the package to the tree must ensure that
    they are able to fix any issues which may arise.

    Sometimes upstream may have a reason for not wanting their package included
    in the tree. This should be respected.

Reasonably Stable
    Keep super-experimental things out of the tree. If you must commit them,
    consider using ``package.mask`` until things calm down, or better yet make
    them available as overlay ebuilds.

Reasonably Useful
    Don't feel obliged to include "Joe's '1337 XMMS Skinz Collection" or "Hans'
    Super Cool Fast File System" in the tree just because a few users ask for
    it. Stick to things that might actually be of use.

Properly Packaged
    If something is only available in live CVS or dodgy autopackage format,
    don't include it until upstream can come up with a decent source package.
    Similarly, avoid things that don't have a proper build system (where
    relevant) -- these are very tricky to maintain.

Patching and Distribution Permitted
    If we can't patch packages as necessary ourselves, we end up relying
    entirely upon upstream for support. This can be problematic, especially if
    upstream are slow at fixing things. We don't want to be in the situation
    where we can't stable a critical package because we're still waiting for a
    closed-source vendor to get their act together.

    Similarly, not being able to mirror and distribute tarballs ourselves makes
    us rely entirely upon upstream mirrors. Experience has shown that these are
    often extremely unreliable, with files changing, moving or vanishing at
    random.

Working Ebuilds
    If you don't have a *working* ebuild, don't include it.

Portable
    If software is unportable, it's generally because it's badly written.
    Remember that although x86 has a market majority *now*, it probably won't in
    the not too distant future once x86-64 catches on.

Reasonable Security Record
    Don't include software that has a terrible security record. Each
    vulnerability is a *lot* of work for a lot of people (security teams, arch
    teams and package maintainers).

Obviously, sometimes exceptions are necessary. We include PHP in the tree
*despite* its security record, for example, because it's a popular package and
we're 'expected' to have it. These are merely guidelines.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

