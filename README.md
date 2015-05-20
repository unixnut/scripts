scripts
=======

Small, useful platform-agnostic scripts (mostly just for Linux) that don't justify having their own repo

Highlights
----------
* **[clowncar](clowncar)**: This is a wrapper for `useradd` that handles an
  SSH public key.  It can be run in order to create a user immediately, or be
  run in "clowncar factory mode" to create a script that will create the user
  later.  In either case it prompts for a key.
