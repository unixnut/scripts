#! /bin/sh
# d (Bourne shell script) -- Decrypts a GnuPG-encrypted file to STDOUT
#
# Auto-hides un-necessary output

temp_file=/tmp/d_$$.output

set -e
# prepare the file in a secure manner (even though it only holds metadata)
install -m 600 /dev/null $temp_file
# process all args
for input_file ; do
  # sh reports errors with redirected files to STDERR even if it's redirected
  if gpg < "$input_file" 2>> $temp_file
  then
    echo
  else
    :
    ## echo "decrypt of '$input_file' failed" >&2
  fi
done
