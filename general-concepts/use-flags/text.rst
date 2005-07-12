USE Flags
=========

USE flags are to control *optional* dependencies and settings which the user may
reasonably want to select. For example, ``vim`` can optionally build with
support for the ``ruby`` interpreter, and it needs ``ruby`` installed to do this
-- we use the ``ruby`` USE flag to provide this option. On the other hand,
``glark`` requires ``ruby`` no matter what, so no USE flag is used here.

No combination of USE flags should cause a package to fail to build.

Packages should not configure and link based upon what is available at compile
time -- any autodetection must be overridden.

``noblah`` USE Flags
--------------------

If at all possible, avoid ``noblah`` style USE flags. These break ``use.mask``
and cause all sorts of complications for arch developers. Here's why:

Consider a hypothetical package named 'vplayer', which plays videos. This
package has optional support, via USE flags, for various sound and video output
methods, various video codecs and so on.

One of vplayer's optional features is support for the 'fakemedia' codec, which
is unfortunately only available as a dodgy x86 binary. We *could* handle this by
doing something like:

.. CODESAMPLE noblah-1.ebuild

Except this is pretty nasty -- what happens when an amd64 binary is made as
well? Also, users on other archs will see fakemedia listed in ``emerge -pv``
output, even though it is not actually available.

Similarly, say vplayer supports output via the ALSA codec as one option.
However, ALSA isn't (or wasn't when this example was written) available on sparc
or alpha. So we could do:

.. CODESAMPLE noblah-2.ebuild

Again, it's messy, and alsa still shows up in the ``emerge -pv`` output. Also,
once ALSA starts working on sparc, every ebuild that does this would have to be
manually edited.

The solution is ``use.mask``, which is documented in `Profiles use.mask File`_.
Each profile can have a ``use.mask`` file which can be used to forcibly disable
certain USE flags on a given arch (or subarch, or subprofile). So, if the
``fakemedia`` USE flag was use.masked on every non-x86 profile, the following
would be totally legal and wouldn't break anything:

.. CODESAMPLE noblah-3.ebuild

Users of non-x86 would see the following when doing ``emerge -pv vplayer``: ::

    [ebuild   R   ] media-video/vplayer-1.2 alsa -blah (-fakemedia) xyz

To get a flag added to ``use.mask``, ask the relevant arch team.

So what's the problem with ``noblah`` flags?

There's no way to forcibly *enable* a given USE flag on a particular profile.
So, something like:

.. CODESAMPLE noblah-4.ebuild

will make your package unusable by archs without ALSA support, and there is no
way to fix it that doesn't involve adding in nasty ``arch?`` flags.

Local and Global USE Flags
--------------------------

USE flags are categorised as either local or global. A global USE flag must
satisfy several criteria:

    * It is used by many different packages.
    * It has a general non-specific purpose.

The second point is important. If the effect of the ``thing`` USE flag upon
``pkg-one`` is substantially different from the effect it has upon ``pkg-two``,
then ``thing`` is not a suitable candidate for being made a global flag. In
particular, note that if ``client`` and ``server`` USE flags are ever
introduced, they can not be global USE flags for this reason.

Before introducing a new global USE flag, it must be discussed on the gentoo-dev
mailing list.

USE Flag Descriptions
---------------------

All USE flags (excluding ``USE_EXPAND`` flags) must be described in either
``use.desc`` or ``use.local.desc`` in the ``profiles/`` directory. See
`portage-5`_ or the comments in these files for an explanation of the format.
Remember to keep these files sorted.

Conflicting USE Flags
---------------------

Occasionally, ebuilds will have conflicting USE flags for functionality.
Checking for them and returning an error is *not* a viable solution. Instead,
you must pick one of the USE flags in conflict to favour.

One example comes from the ``msmtp`` ebuilds. The package can use either SSL
with GnuTLS, SSL with OpenSSL, or no SSL at all. Because GnuTLS is more
featureful than OpenSSL, it is favoured:

.. CODESAMPLE conflicting-flags.ebuild

USE_EXPAND and ARCH USE Flags
-----------------------------

The ``VIDEO_CARDS``, ``INPUT_DEVICES`` and ``LINGUAS`` variables are
automatically expanded into USE flags. These are known as ``USE_EXPAND``
variables. If the user has ``LINGUAS="en fr"`` in ``make.conf``, for example,
then ``USE="linguas_en linguas_fr"`` will automatically be set by portage.

The ``USE_EXPAND`` list is set in ``profiles/base/make.defaults`` as of Portage
2.0.51.20. This must not be modified without discussion on the gentoo-dev list,
and it must not be modified in any subprofile.

The current architecture (eg ``x86``, ``sparc``, ``ppc-macos``) will
automatically be set as a USE flag as well. See ``profiles/arch.list`` for a
full list of valid architecture keywords, and `GLEP 22`_ for an explanation of
the format.

.. Warning:: It is a common misconception that the architecture variable is somehow
    related to ``ACCEPT_KEYWORDS``. It isn't. Accepting ``x86`` keywords on
    ``sparc``, for example, won't set ``USE="x86"``. Similarly, there are no
    ``~arch`` USE flags, so don't try ``if use ~x86``.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
