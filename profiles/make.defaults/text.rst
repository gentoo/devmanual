Profiles ``make.defaults`` File
===============================

The ``make.defaults`` file in ``profiles/`` provides a minimal set of defaults
for the kinds of values which may be set in ``make.conf`` (``CFLAGS``, ``USE``,
``FEATURES`` etc) along with certain control variables (eg ``USE_EXPAND``).
These values can further be refined by additional ``make.defaults`` files in
subprofiles.

In general, ``make.defaults`` should not be modified without consulting the
relevant arch team, or ``gentoo-dev`` for high-up ``make.defaults`` files.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
