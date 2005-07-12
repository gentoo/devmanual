Configuration File Protection
=============================

Portage includes a system for configuration file protection which means ebuilds
don't have to worry about accidentally clobbering files in ``/etc``. This is
known as 'protection', and it is controlled by the ``CONFIG_PROTECT`` and
``CONFIG_PROTECT_MASK`` variables.

Any directory which is listed in ``CONFIG_PROTECT`` (and any subdirectories
thereof), except for any which are listed in ``CONFIG_PROTECT_MASK`` (and
subdirectories) are automatically 'protected' by portage when copying an image
from ``DESTDIR`` to ``ROOT``. Rather than installing protected files directly,
portage will install them as ``._cfg0000_filename``. These can then be processed
by the ``etc-update`` or ``dispatch-conf`` files at the user's discretion.

Packages must **not** attempt to override this system via ``pkg_postinst`` or
similar. If you need a file renamed, remove or changed in a particular way, you
should display a message informing the user.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
