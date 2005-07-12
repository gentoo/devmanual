Other Archive Formats
=====================

There are a variety of other archive formats which you may encounter.

Zip Files
---------

If a package is supplied as a ``.zip`` file, you should:

* ``DEPEND`` upon ``app-arch/unzip``
* Use ``unpack`` as normal

Shar Files
----------

If a package is supplied as a ``.shar`` file, you should repackage it locally
into a ``.tar.bz2``. It may also be useful to ask upstream to use a friendlier
package format -- however, if they ship ``.shar``, chances are they haven't done
a release in at least ten years.

RAR Files
---------

``.rar`` files must be repackaged locally into a ``.tar.bz2`` file.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

