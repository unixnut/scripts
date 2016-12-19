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




