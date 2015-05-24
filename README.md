scripts
=======

Small, useful platform-agnostic scripts (mostly just for Linux) that don't justify having their own repo

Highlights
----------
* **[clowncar](clowncar)**: This is a wrapper for `useradd` that handles an
  SSH public key.  It can be run in order to create a user immediately, or be
  run in "clowncar factory mode" to create a script that will create the user
  later.  In either case it prompts for a key.
* **[smooth](smooth)**: Unified wrapper for various source control systems.  Assumes
  collaborative workflow.  [Full documentation](doc/s for smooth source control.md)
* **[userlist](userlist)**: Shows columns of useful information about Unix
  users, including account expiry and everything to do with password (when run
  as root).  Has many modes to show extra stuff.
