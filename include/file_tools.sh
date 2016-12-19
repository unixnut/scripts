# If it's a filename, find the directory
dir_only()
{
  local dir

  if [ -f "$1" ] ; then
    dir=$(dirname "$1")
  else
    dir=$1
  fi

  echo "$dir"
}


# Indicates whether a directory is empty
# Returns: 0 if it is, 1 otherwise
dir_empty()
{
  if [ "$(ls -A "$1")" ]; then
    return 1
  else
    return 0
  fi
}
