USE Flag Conditional Code
=========================

Often a particular block of code must only be executed if a given USE flag is
set (or unset). For large blocks, ``if use foo`` is best, or for inverse tests
either ``if ! use foo`` or ``if use !foo`` can be used (the former is more
common and is recommended for readability). For single-statement conditions, the
``use foo && blah`` (or ``use foo || blah`` for negatives) form is often more
readable.

The ``if [ "`use foo`" ]`` and ``if [ -n "`use foo`" ]`` forms which are
occasionally seen in older code must **not** be used.

.. Note:: ``die`` will not work as expected within a subshell, so code in the
    form ``use foo && ( blah ; blah )`` should be avoided in favour of a proper if
    statement. See `die and Subshells`_.

.. CODESAMPLE use-sample.ebuild

For echoing content based upon a USE flag, there is often a better helper
function available.

You must not rely upon ``use`` producing an output -- this no longer happens.
If you really need output displayed, use the ``usev`` function. The
``useq`` function is available for explicitly requesting no output.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

