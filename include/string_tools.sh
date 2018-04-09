# Usage: glob_match <string> <pattern>
# Returns 0 (success) if the string matches the glob pattern, otherwise 1
#
# Thanks to http://www.etalabs.net/sh_tricks.html
# (Note: fnmatch() parameters reversed)
glob_match()
{
    case "$1" in
        $2) return 0 ;;
        *) return 1 ;;
    esac
}


# Usage: glob_match <string> <pattern>
# Returns 0 (success) if the string matches the glob pattern, otherwise 1
regex_match()
{
    expr "$1" : "$2" > /dev/null 
}


# Merges multiple lines on stardard input into one line, separated by a space
# (by default) or the argument if specified.
mergelines() {
  sed -e ': start'  \
      -e 'N'        \
      -e "s/\\n/${1:- }/"  \
      -e 't start'
}
