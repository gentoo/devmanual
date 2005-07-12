Configuring ``xemacs`` for UTF-8
================================

First, you need to have built ``xemacs`` itself with ``USE=mule``.  Then, the
``app-xemacs/mule-ucs`` package is needed.  To autoload Unicode support,
you can add the following to your ``~/.xemacs/init.el``:

::

    (require 'un-define)

If automatic character set detection on files is not working properly,
here are three commands that can help.

* ``set-buffer-file-coding-system (C-x RET f)`` changes the coding
  system for the current file.
* ``set-default-buffer-file-coding-system (C-x RET F)`` sets the default for
  unsaved buffers and ASCII-looking files that have no obvious character
  set markers for autodetection.
* ``universal-coding-system-argument (C-x RET c)``
  lets you set the coding system for the next command, so issuing
  this from a dired window immediately before opening a problematic file
  is a tactic that can be of use when autodetection gets things
  pathologically wrong.

The current coding system will be displayed near the left edge of the
status line.

