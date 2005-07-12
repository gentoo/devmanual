Licenses
========

All ebuilds must specify a ``LICENSE`` (note the American English spelling)
variable. The value of this variable must be the name of a file in the portage
tree's ``licenses/`` directory.

Adding New Licenses
-------------------

If your package's license is not already in the tree, you must add the license
before committing the package. When adding the license, use a plain text file if
at all possible. Some licenses are PDF files rather than plain text -- this
should only be done if we are legally required to do so.

It is not normally necessary to mail the ``gentoo-dev`` list before adding a new
license. You should only do so if the license could be considered 'questionable'
or if you are unsure as to the meaning of any part of it.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..
