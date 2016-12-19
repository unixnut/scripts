# Sets <$1> to $2, or increases <$1> if $2 is absent.
numeric_opt()
{
  # sanitise the value by aggressively stripping off a non-numeric suffix
  local value=${2%%[^0-9]*}

  if [ -z "$value" ] ; then
    eval "$1=\$(($1 + 1))"
  else
    eval "$1=$value"
  fi
}


# Make copies of a config file pointed to by a variable, "back up" the variable
# contents and then change it to point to the copied file.
make_fake()
{
  local location=$2
  local file copy

  # make a convenience copy of the variable and back up the contents
  eval file=\$$1
  eval real_$1=$file

  if [ -f $file ] ; then
    alternate_file=$location/${file##*/}
    cp -p $file $alternate_file
  fi

  # change the variable
  eval $1=$alternate_file
}


parse_cmdline()
{
  echo "there's no point trying this, because the intermediate variable
\$orthogonal_opts is necessary to allow getopt to bomb out in the case of
errors"
  exit 99
}
