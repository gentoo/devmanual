Package and Category metadata.xml
=================================

The ``metadata.xml`` file is used to specify additional data about a package or
category.

Category Metadata
-----------------

For categories, ``metadata.xml`` specifies a long description (in English and
optionally in other languages). The format is specified formally in `GLEP 34`_,
and the character set **must** be UTF-8 as specified by `GLEP 31`_. A typical
example:

.. CODESAMPLE catmetadata.xml


When creating a new category, creating a ``metadata.xml`` file along with a
``<longdescription>`` in English is **mandatory**. Translations are handled by
any interested developer who speaks a language sufficiently well.

The correct way to commit a *category* ``metadata.xml`` file is currently: ::

    xmllint --noout --valid metadata.xml
    glep31check metadata.xml
    cvs commit -m "blah" metadata.xml

Package Metadata
----------------

For packages, ``metadata.xml`` can specify a long description and maintainer
information. If a long description in any language is provided, an English long
description must be present. A typical example might look like:

.. CODESAMPLE pkgmetadata.xml


All new packages **must** include a ``metadata.xml`` file which specifies *at
least* a herd. If no herd is suitable, ``no-herd`` should be used, and at least
one maintainer **must** be listed -- however, if at all possible, find a herd
willing to be listed.

Commits of package metadata files are handled by ``repoman``. You should ensure
that you have ``dev-libs/libxml2`` installed so that the XML can be validated.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

