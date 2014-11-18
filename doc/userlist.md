Ever wanted the ability to list Unix/Linux users from the command line, leaving
out system users by default?  [userlist]() does this.  (See the help() function
for usage information.)

By default, **userlist** runs in privileged mode, showing password and account
expiry information (including user status: active/disabled/expired).  This mode
requires it to be run as the root user.  It can optionally show information
from the passwd file like full name, and/or group information, for each user.  

When run in unprivileged mode, **userlist** just shows passwd file information
and optional group information.

**userlist** is also designed to have its output redirected to a file or piped
to **less**, in which case it can be told to output all information for each
user on a single line.
