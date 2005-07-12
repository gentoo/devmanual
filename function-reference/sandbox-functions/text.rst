Sandbox Functions Reference
===========================

The following functions, which are all provided by ``ebuild.sh``, handle working
with the sandbox.

====================== ======================================================
Function               Details
====================== ======================================================
``addread``            Add one single additional item to the sandbox allowed
                       read list.
``addwrite``           Add one single additional item to the sandbox allowed
                       write list. **Note**: If at all possible, use
                       ``addpredict`` instead. Using ``addwrite`` is **not** an
                       appropriate alternative to making your package build
                       sandbox-friendly.
``adddeny``            Add one single additional item to the sandbox deny write
                       list.
``addpredict``         Add one single additional item to the sandbox predict
                       (pretend to allow write) list.
====================== ======================================================

None of these functions accept multiple arguments in one call. The sandbox is
recursive, so to allow predicted writes to ``/foo/bar`` and ``/foo/baz``,
``addpredict /foo`` would be sufficient.

See `Sandbox`_ for details on how the sandbox works. See `Handling Access
Violations`_ for how to handle sandbox-related build problems.

.. vim: set ft=glep tw=80 sw=4 et spell spelllang=en : ..

