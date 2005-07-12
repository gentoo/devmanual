Overlay
=======

Portage can look in multiple places for packages by using an overlay. The
locations of overlays are controlled by the ``PORTDIR_OVERLAY`` variable, which
should contain a space-separated list of paths.

The overlay should contain the same directory structure as ``PORTDIR`` (although
only the necessary directories need be included). For example, a simple overlay
might have a directory structure like: ::

    overlay
    |-- dev-util
        `-- gengetopt
            |-- Manifest
            |-- files
            |   `-- digest-gengetopt-2.13
            `-- gengetopt-2.13.ebuild

An overlay can be used to 'add' items to the tree (although you must ensure that
``/etc/portage/categories`` is used if any new categories are added) or to
override existing entries.

Overlay and Eclasses
--------------------

Be very careful when using eclasses in an overlay. Portage will not do cache
updates when an overlay eclass is changed, nor will it do cache updates when a
main portage tree eclass which is used by an overlay ebuild changes. You may
also encounter bogus 'illegal inherit' notices when working with eclasses in
overlay (see `QA Notice -- ECLASS foo inherited illegally`_). To be safe,
manually ``touch`` all relevant overlay files after updating overlay eclasses.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

