# Usage: user_homedir <username>
user_homedir()
{ 
  [ $# -lt 1 ] && return 1 
  getent passwd $1 | cut -f6 -d:
}
