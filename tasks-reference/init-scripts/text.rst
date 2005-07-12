Init Scripts
============

Init scripts should be installed into ``/etc/init.d`` using the ``doinitd`` or
``newinitd`` functions (see `Install Functions Reference`_). Any configuration
(commandline parameters or environment variables) for these scripts should be
handled via entries in ``/etc/conf.d`` with the same filename -- ``doconfd`` or
``newconfd`` can be used to install these.

An overview of the Gentoo init system and how to write init scripts is available
in the `main handbook Writing Init Scripts section
<http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=2&chap=4#doc_chap4>`__.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

