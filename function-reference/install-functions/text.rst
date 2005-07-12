Install Functions Reference
===========================

The following functions, which are all provided ``ebuild.sh`` and the standard
library, handle various install-related tasks. ``${D}`` is automatically handled
for all of these functions.

============== ======================================================
Function       Details
============== ======================================================
``insinto``    Change install location for ``doins``, ``newins`` etc
``exeinto``    Change install location for ``doexe``, ``newexe`` etc
``docinto``    Change install location for ``dodoc``, ``newdoc`` etc
``insopts``    Specify arguments passed to ``install`` (eg ``-s``, ``-m644``).
``diropts``    Specify arguments passed to ``install`` for directories
``exeopts``    Specify arguments passed to ``install`` for executables
``libopts``    Specify arguments passed to ``install`` for libraries
``dobin``      Install a binary
``doconfd``    Install an ``/etc/conf.d`` file
``dodir``      Install a directory
``dodoc``      Install a documentation file
``doenvd``     Install an ``/etc/env.d`` file
``doexe``      Install an executable
``dohard``     Create a hardlink to the first argument from the second argument
``dohtml``     Install an HTML documentation file
``doinfo``     Install a GNU Info document
``doinitd``    Install an ``/etc/init.d`` file
``doins``      Install a miscellaneous file
``dojar``      Install a ``.jar`` file
``dolib``      Install a library file
``dolib.a``    Install a library (``.a``) file
``dolib.so``   Install a library (shared object) file
``doman``      Install a man page
``domo``       Install a Gettext ``.mo`` file
``dopython``   Install a Python file
``dosbin``     Install an ``sbin/`` file
``dosym``      Create a symlink from the second parameter to the first
               parameter
``fowners``    Call ``chown`` with the first argument as the mode on all
               additional arguments.
``fperms``     Call ``chown`` with the first argument as the user on all
               additional arguments.
``keepdir``    Create a directory with an empty ``.keep`` file in it.
``newbin``     Install a binary using the second argument as the name.
``newconfd``   Install an ``/etc/conf.d`` entry using the second argument as the
               name.
``newdoc``     Install a documentation file using the second argument as the
               name.
``newenvd``    Install an ``/etc/env.d`` file using the second argument as the
               name.
``newexe``     Install an executable file using the second argument as the name.
``newinitd``   Install an ``/etc/init.d`` file using the second argument as the
               name.
``newins``     Install a miscellaneous file using the second argument as the
               name.
``newlib.a``   Install a ``.a`` library file using the second argument as the
               name.
``newlib.so``  Install a ``.so`` library file using the second argument as the
               name.
``newman``     Install a manual page using the second argument as the name.
``newsbin``    Install an ``sbin`` file using the second argument as the name.
============== ======================================================

The ``do*`` functions, when given multiple arguments, will work upon multiple
targets. The ``new*`` functions take exactly two arguments (except as noted) --
the first is the source name, the second the name to use when installing.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


