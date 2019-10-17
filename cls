#! /bin/bash
# c*ls  (BASH script) -- Colourised ls wrappers that use a pager
#
# Version:   
# Copyright: (c)2018 Alastair Irvine <alastair@plug.org.au>
# Keywords:  
# Notice:    
# Licence:   This file is released under the GNU General Public License
#
# Description: Uses colour and pipes output to less, with a sensible prompt.
#
# 
#
#   cls      ls -FC
#   clls     ls -lF --time-style=long-iso
#   cllls    ls -lF --time-style=full-iso
#   cals     ls -FCA
#   calls    ls -lFA --time-style=long-iso
#   callls   ls -lFA --time-style=full-iso
#   csls     sudo ls -FC
#   cslls    sudo ls -lF --time-style=long-iso
#   csllls   sudo ls -lF --time-style=full-iso
#   csals    sudo ls -FCA
#   csalls   sudo ls -lFA --time-style=long-iso
#   csallls  sudo ls -lFA --time-style=full-iso
#   
#
# Usage: 
# Options:
#   
#
# Licence details:
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 2 of the License, or (at
#     your option) any later version.
#
#     See http://www.gnu.org/licenses/gpl-2.0.html for more information.
#
#     You can find the complete text of the GPLv2 in the file
#     /usr/share/common-licenses/GPL-2 on Debian systems.
#     Or see the file COPYING in the same directory as this program.
#
#
# TO-DO:
#   + Truncate owner/group as needed to fit within MULTI_COL_WIDTH
#   + LINK_COL_WIDTH


self=`basename "$0"`


# *** FUNCTIONS ***


# *** MAINLINE ***


# == sanity checking ==


# == preparation ==
case ${0##*/} in
  cls)      short_opts=-FC  ; long_opts=--time-style=long-iso ;;
  clls)     short_opts=-lF  ; long_opts=--time-style=long-iso ;;
  cllls)    short_opts=-lF  ; long_opts=--time-style=full-iso ;;
  cals)     short_opts=-FCA ; long_opts=--time-style=long-iso ;;
  calls)    short_opts=-lFA ; long_opts=--time-style=long-iso ;;
  callls)   short_opts=-lFA ; long_opts=--time-style=full-iso ;;
  csls)     sudo=y ; short_opts=-FC  ; long_opts=--time-style=long-iso ;;
  cslls)    sudo=y ; short_opts=-lF  ; long_opts=--time-style=long-iso ;;
  csllls)   sudo=y ; short_opts=-lF  ; long_opts=--time-style=full-iso ;;
  csals)    sudo=y ; short_opts=-FCA ; long_opts=--time-style=long-iso ;;
  csalls)   sudo=y ; short_opts=-lFA ; long_opts=--time-style=long-iso ;;
  csallls)  sudo=y ; short_opts=-lFA ; long_opts=--time-style=full-iso ;;
esac


# == processing ==
declare -i extra_cols ownership_cols=2
inums=n
f=("$@")
while [[ $# > 0 && "$1" == -* ]] ; do
  case "$1" in
    --*) ;;
    *)   if [[ "$1" == -*i* ]] ; then
           let ++extra_cols
           inums=y
         fi
         [[ "$1" == -*s* ]] && let ++extra_cols ## blocks=y
         if [[ "$1" == -*g* ]] ; then
           let --extra_cols
           let --ownership_cols ## no_owner=y
         fi
         if [[ "$1" == -*[oG]* ]] ; then
           let --extra_cols
           let --ownership_cols ## no_group=y
         fi
         [[ "$1" == -*h* ]] && human=y
         ;;
  esac
  shift
done

let size_column=5+extra_cols
let before_size_column=size_column-1
if [ -n "$sudo" ] ; then
  sudo ls $short_opts --group-directories-first --color=always $long_opts "${f[@]}"
else
  ls $short_opts --group-directories-first --color=always $long_opts "${f[@]}"
fi |
  python -c 'import re, sys
size_column = int(sys.argv[1]) - 1
inums_on = sys.argv[2] == "y"
ownership_cols = int(sys.argv[3])
if inums_on:
  dir_column = 1
else:
  dir_column = 0

def colorise(s):
  """Colorise integer values using underlines and colorise values with a suffix
  as ...  ."""
  import colored
  COLOURS = {"E": "purple_1b", "P": "deep_pink_2", "G": "magenta_2b", "M": "indian_red_1c", "K": "tan"}
  try:
    int(s) 
    def tweak(s, n=0):
      if not s:
	return 0, ""
      else:
	count, s_prime = tweak(s[1:], n+1)
        # Odd modulo 3
        if (count / 3) % 2 == 1 and s_prime:
	  return count + 1, s[0] + "\b_" + s_prime
	else:
	  return count + 1, s[0] + s_prime

    ## return s + "\b_"
    length, string = tweak(s)
    return string
  except ValueError:
    suffix = s[-1]
    try:
      colour = COLOURS[suffix]
      return "%s%s%s%s" % (colored.fg(colour), s[0:-1], colored.attr("reset"), suffix)
    except KeyError:
      return s

SIZE_COL_WIDTH = 12
MULTI_COL_WIDTH = 20 + SIZE_COL_WIDTH
LINE_REGEX = re.compile(r"\s*\S+")
ISDIR_REGEX = re.compile(r"\s*d")
for line in sys.stdin:
  ## print len(line)
  cols = LINE_REGEX.findall(line)
  # Is this a long listing?
  if len(cols) >= size_column + 3:
    size_str = cols[size_column].strip()
    if ISDIR_REGEX.match(cols[dir_column]):
      size_output = size_str
    else:
      size_output = colorise(size_str)
    # Check for column blending, i.e. owner/group suffix blends in with size prefix
    ## if (inums_on and size_column == 3) or size_column == 2:
    if ownership_cols == 0:
      # no owner/group column blending for size
      print "%s %*s%s" % ("".join(cols[0:size_column]), SIZE_COL_WIDTH, size_output, "".join(cols[size_column+1:]))
    else:
      # owner/group column blending for size
      ownership_output = "".join(cols[size_column-ownership_cols:size_column])
      sep_str = " " * (MULTI_COL_WIDTH - len(ownership_output + size_str))
      multicol_output = ownership_output + sep_str + size_output
      print "%s%s%s" % ("".join(cols[0:size_column-ownership_cols]), multicol_output, "".join(cols[size_column+1:]))
  else:
    print line,' $size_column $inums $ownership_cols |
  less -RS --prompt=M"[%pB\\%] $*"
  ##   sed "s/^\\(\\([^[:space:]]\\+[[:space:]]\\+\\)\\{1,$before_size_column\\}\\)\\([^[:space:]]\\+\\)/\\1[\\3]/" |

