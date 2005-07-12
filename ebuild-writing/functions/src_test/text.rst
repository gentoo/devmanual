src_test
========

+------------------+---------------------------------------------------+
| **Function**     | ``src_test``                                      |
+------------------+---------------------------------------------------+
| **Purpose**      | Run pre-install test scripts.                     |
+------------------+---------------------------------------------------+
| **Sandbox**      | Enabled                                           |
+------------------+---------------------------------------------------+
| **Privilege**    | user                                              |
+------------------+---------------------------------------------------+
| **Called for**   | ebuild                                            |
+------------------+---------------------------------------------------+

Default ``src_test``
--------------------

.. CODESAMPLE default-sample.ebuild

Sample ``src_test``
-------------------

.. CODESAMPLE sample-sample.ebuild

Common ``src_test`` Tasks
-------------------------

Often the default ``src_test`` is fine. Sometimes it is necessary to remove
certain tests from the list if they cannot be used with a portage environment.
Reasons for such a failure could include:

* Needing to use X.
* Needing to work with files which are disallowed by the sandbox.
* Requiring user input (``src_test`` must not be interactive).
* Requiring root privileges.

Usually, removing the relevant test from the ``Makefile`` using ``sed`` or
skipping a particular ``make`` target is sufficient.

.. Note:: ``emake`` should not be used for ``src_test`` -- trying to parallelise
    tests unless the ``Makefile`` was specifically designed for this can cause all
    sorts of strange problems.

Try to ensure that tests work properly for your ebuild. A good test suite is
extremely helpful for arch maintainers.

Skipping Tests
--------------

Sometimes it is necessary to skip tests entirely. This can be done using a dummy
``src_test`` function:

.. CODESAMPLE true-sample.ebuild

Another option would be to set ``RESTRICT="test"`` in the ebuild.

.. Note:: If upstream provide a test suite which doesn't work, consider talking
    to them about getting it fixed. A broken test suite is worse than no test
    suite at all, since we are unable to tell whether a test failure indicates a
    genuine fault.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

