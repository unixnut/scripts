#! /bin/sh
# logging.sh (Bourne shell script) -- runs some tests on include/logging.sh

# Find the include files that are present in the repo working directory,
# or installed somewhere.
case "$0" in
  /usr/local/*) SCRIPT_INCLUDE_DIR=/usr/local/share/unixnut-scripts/include ;;
  /usr/*)       SCRIPT_INCLUDE_DIR=/usr/share/unixnut-scripts/include ;;
  *)            SCRIPT_INCLUDE_DIR=$(dirname "$0")/../include
esac

self=$(basename "$0")
syslog_facility=user

. $SCRIPT_INCLUDE_DIR/logging.sh


# *** MAINLINE ***
min_log_level=$LOG_NOTICE
syslog_error foo
log_info bar
log_warning baz

echo ========
if [ -f /var/log/syslog ] ; then
  tail -n 3 /var/log/syslog
else
  tail -n 3 /var/log/messages
fi
echo ========
