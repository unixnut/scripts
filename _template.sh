
# Find the include files that are present in the repo working directory,
# or installed somewhere.
case "$0" in
  /usr/local/*) SCRIPT_INCLUDE_DIR=/usr/local/share/unixnut-scripts ;;
  /usr/*)       SCRIPT_INCLUDE_DIR=/usr/share/unixnut-scripts ;;
  *)            SCRIPT_INCLUDE_DIR=$(dirname "$0")/include
esac
