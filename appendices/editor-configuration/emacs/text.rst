Configuring ``emacs`` for UTF-8
===============================

Emacs 21 has built-in Unicode support, and (fortunately) it supports
UTF-8 far better than UTF-16 and other variants. Some extensions to this
functionality are available in the package ``app-emacs/mule-ucs``, although
this is not necessary (and I would not recommend it unless absolutely
necessary, as the potential for unexpected bugs or quirky behaviour is
increased).

In versions of Emacs below 21.3, and a non-UTF-8 locale is used when
opening a UTF-8 file, auto-detection of the character set is effectively
disabled and characters will be garbled. The UTF-8 character set can be
preferred with ``M-x prefer-coding-system`` and entering ``utf-8`` when
prompted. Otherwise, it is necessary to tell Emacs that a UTF-8 file is
being opened by prefixing the ``C-x C-f`` or ``C-x C-v`` command with
``C-x C-m c utf-8 RET``. As a diagnostic measure, the coding system currently
in use can be determined with ``C-h C <RET>``.

Newer Emacs versions will autodetect the coding system for given text.

If it is desired to prefer UTF-8 to the regular character set,
the following can be used inside of the Emacs startup file:

::

    (prefer-coding-system 'utf-8)

For specifying coding system to use on a per-file basis, the
modify-coding-system function can be used.

Further reading:

* http://www.gnu.org/software/emacs/manual/emacs.html#Recognize%20Coding
* http://www.gnu.org/software/emacs/manual/emacs.html#Specify%20Coding
* http://www.emacswiki.org/cgi-bin/wiki/UnicodeEncoding
* http://www.emacswiki.org/cgi-bin/wiki/ChangingEncodings

