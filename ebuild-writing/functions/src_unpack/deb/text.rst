Deb Sources
===========

.. Todo:: write this. from vapier:  we dont have to 'handle' these because all
    debian packages have a source tarball ... the .deb format is pretty simple
    though, it's managed by the 'ar' utility from binutils.  you can unpack a
    .deb by simply doing `ar x blah.deb` ... this will give you three files:
    debian-binary: plain text file which just contains version number of the
    .deb format control.tar.gz: a few files which control installing/verifying
    of package data.tar.gz: all the compiled files ... you could just extract it
    to /


.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..


