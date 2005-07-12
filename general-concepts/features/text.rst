FEATURES
========

The ``FEATURES`` variable specifies options which affect how portage operates
and how packages are compiled. It is **not** used for settings which have a
substantial effect upon the resulting generated package.

Relevant ``FEATURES`` for developers include:

``autoaddcvs``
    Automatically runs a ``cvs add`` for certain files.

``collision-protect``
    Raise an error if an installing package attempts to overwrite a file which
    is provided by a different package.

``cvs``
    Generate proper digests even when ``SRC_URI`` has conditional elements.

``sandbox``
    Enable the sandbox.

``sign``
    GPG sign manifest files.

``strict``
    Do some extra checks for potentially dangerous situations (eg missing
    ``Manifest`` files).

``test``
    Enable the ``src_test`` phase.

``userpriv``
    Drop to non-root privileges for certain phases.

``usersandbox``
    Enables the sandbox even when running non-privileged.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

