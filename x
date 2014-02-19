#!/bin/csh -f
# x (csh script) -- Spawns off an xterm that is connected to the specified
#                   machine.  Just does an rlogin if -s is specified.
# Usage: x [-p] [-d] [-n|-s] [-e] [<machine>][%<zone>] [<username>]
#    or: x [-p] [-d] [-n|-s] -t [<machine> [<port>]]
# If rlogin is used and it returns a non-zero error code, -p is assumed.
# <zone>, if specified, indicates a certain set of defaults for the machine
# name, domain and username.  Any of these may still be specified.
#
# Options:
#   -p   causes the xterm to await a press of the [ENTER] key before quitting.
#   -r   gets xterm to run rlogin instead of the other way around
#   -t   makes x connect to <machine> using telnet instead of rlogin.
#        <port>, if given, is used as the port to connect to with telnet.
#   -e   (encrypted) use ssh (display forwarding is turned off)
#   -f   Use display forwarding with ssh
#   -E   gets ssh to run xterm instead of the other way around (forces -ef) 
#   -1   Use ssh1 instead of ssh2
#   -n   Don't run xhost.  Normally, xhost is used to automatically to give
#        the destination machine access to the calling machine's X display.
#        If an XAUTHORITY file exists, the relevant display key is
#        instead transferred using rsh before connecting.  The
#        remote host is responsible for cleaning this up upon logout.
#   -s   Just run rlogin/telnet as a child of this script, not bothering with
#        an xterm.  This option is set automatically if <DISPLAY> is not set.
#   -d   (debug mode) displays the command line before execution (amongst
#        other things)
#   -c   charged.  Uses runsocks
#
# Configuration variables:
#   X_DEFAULT_HOST         The default host and/or zone to connect to
#   X_DEFAULT_<zone>_HOST  The host to connect to if just a zone is specified
#   X_USE_SSH              duh

alias print_error 'sh -c "echo `basename $0`: \!* >&2"'

while (x$1 =~ x-*)
  set options=`echo "x$1" | cut -c3-`
  shift
  while ("x$options" != "x")
    set switch_char=`echo "x$options" | cut -c2`
    set options=`echo "x$options" | cut -c3-`
    if ("x$switch_char" == "x-") then    # handle GNU-style long options
      set switch_char="$options"
      set options=
    endif
    set option_$switch_char
    switch ($switch_char)
      case "t":
      case "p":
      case "s":
      case "n":
      case "e":
      case "E":
      case "d":
      case "1":
      case "f":
      case "r":
      case "c":
        breaksw
      default:
        print_error invalid option -$switch_char encountered.
        set switch_error
    endsw
  end
end
unset switch_char


if (! $?switch_error) then
  if (! $?DISPLAY) set option_s

  # Extract the destination tuple and the username (if specified), from
  # the command line:
  if ($#argv) then
    set dest = $1
    if ($#argv >= 2) set port_or_remote_user=$2
  else
    set dest = $X_DEFAULT_HOST
  endif

  # Provided x-in-rsh-mode style logins for ssh
  if ($?option_E) then
    set option_e option_f
  endif

  # Parse the result, splitting it into machine name and zone,
  # filling in the blanks as necessary:
  set machine = (`echo $dest | sed -e 's/%/ .boing. /'`)
  if ($#machine == 3) then
    set target_zone = $machine[3]
    set machine = $machine[1]
  else if ($#machine == 2) then
    # Just "%" and a zone was given, so check for the existence of an
    # environment variable specifying the default machine for that zone:
    set target_zone = $machine[2]
    set default_exists = `eval echo \$\?X_${target_zone}_DEFAULT`
    if ($default_exists) then
      set machine = `eval echo \$X_${target_zone}_DEFAULT`
    else
      print_error no default host for ${target_zone}\; try setting X_${target_zone}_DEFAULT
      set exit_code = 1
    endif
  endif

  if (! $?exit_code) then
    if ($?target_zone) then
      # Add the relative domain name for the specified zone to
      # the machine name:
      set machine = `fqdn -z $target_zone $machine`
    endif
    set shortname = `echo $machine | sed -e 's/\..*//'`
    if (! $?target_zone) then
      if ($shortname == $machine) then
        set target_zone = $ZONE
      else
        set target_zone = unknown
      endif
    endif
    
    if ($?option_c) then
      set prefix = runsocks
    else
      set prefix
    endif

    # Set the command, options and username flags as necessary:
    
    set user_option
    if ($?option_t) then
      set command_line = (telnet $machine)
      if ($?port_or_remote_user) then
        set command_line = ($command_line $port_or_remote_user)
      endif
    else
      if ($?option_e || $?X_USE_SSH) then
        set remote_sh = ssh`if ($?option_1) echo 1`
        set remote_login = $remote_sh
        set basic_command_line = ($machine)
        if ($?port_or_remote_user) then
          set basic_command_line = ($port_or_remote_user@$basic_command_line)
        endif
        if (! $?option_f) then
          set basic_command_line = ('-x' $basic_command_line)
        endif
      else
        set remote_sh = rsh
        set remote_login = rlogin
        set basic_command_line = ($machine `if ($OS != Linux) echo ' -8'`)
        if ($?port_or_remote_user) then
          set user_option = (-l $port_or_remote_user)
          set basic_command_line = ($basic_command_line $user_option)
        endif
      endif
      set command_line = ($remote_login $basic_command_line)
    endif
    
    if ($?option_s) then
      $prefix $command_line
    else
      # Disable the escape character if running telnet or rlogin in an xterm:
      if ($?option_t) then
        set command_line = ($command_line[1] -E $command_line[2*])
      else
        if (! ($?option_e)) then
          if ($BINARY_TYPE == alpha-OSF1 || $OS =~ IRIX*) then
            set command_line = ($command_line -e \'\')
          else
            set command_line = ($command_line -E)
          endif
        endif
      endif

      set xterm_options = (-cn -T $machine -n $shortname)
      if (-f ~/.xrc) then
        set offset=`cat ~/.xrc`
        @ offset += 50
        echo $offset > ~/.xrc
        set xterm_options = ($xterm_options:q -geometry +$offset+$offset)
      endif
  
      if ($target_zone != $ZONE) set acl_blocked
      if ($?X_FRIENDLY_HOSTS) then
        if (\ $X_FRIENDLY_HOSTS\  !~ *$shortname%$target_zone* || \
            \ $X_FRIENDLY_HOSTS\  !~ *%$target_zone*) unset acl_blocked
      endif
      if ($?X_UNFRIENDLY_HOSTS) then
        if ($X_UNFRIENDLY_HOSTS\  =~ *$shortname%$target_zone*) set acl_blocked
      endif
      if ($?option_e && ! $?option_E || $?option_t || $?option_r || $?acl_blocked) then
        if ($?option_p) then
          set other='; echo "Press <ENTER> to close window...  " ; line'
        else if (! $?option_t) then
          set other = ' ; status=$? ; if [ $status = 1 ] ; then echo -n "rlogin exited with status $status.  Press <ENTER> to close window...  " ; line ; fi '
        else
          set other
        endif
      	
        if ($?option_d) then
          set command_line = "echo command_line = $command_line ; $command_line"
        endif
      	
        xterm $xterm_options:q -e sh -c "stty cs8 -istrip ; $prefix $command_line$other" >>& $CONSOLE &
    	
        if (! ($?option_n || ($?option_e && $?option_f))) then
          if (! $?XAUTHORITY && ! -f ~/.Xauthority || $?option_t) then
            if ($shortname != $HOST || $target_zone != $ZONE) then
              if ($?REMOTEHOST && ! $?X_LOGIN) then
                echo "Run "\"xhost $machine\"" on a $REMOTEHOST login\!"
              else
                xhost $machine
              endif
            endif
          else
            if ($target_zone != $ZONE) then
              echo Sending X display key to $machine...
              xauth extract - `if ($DISPLAY =~ :*) echo $HOST`$DISPLAY | $remote_sh `if ($?option_e) echo -x` $machine $user_option 'if (! $?XAUTHORITY && ! -f ~/.Xauthority) xauth merge -'
              ## xauth list | awk '$1 == "'`if ($DISPLAY =~ :*) echo $HOST``echo $DISPLAY | sed -e s/.0//`'" { print $3 }' | $remote_sh $machine $user_option 'if (! $?XAUTHORITY && ! -f ~/.Xauthority) xauth merge -'
            endif
          endif
        endif
      else
        set display_command_line = (set starting_xterm ; enableX)
        if (! $?option_f) then
          set display_command_line = (setenv DISPLAY `if ($DISPLAY =~ :*) echo $HOST`$DISPLAY ; $display_command_line)
        endif
        if ($?option_d) echo $remote_sh $basic_command_line \; $display_command_line \; detach xterm $xterm_options:q -ls
        if (! $?option_f) then
          $remote_sh $basic_command_line setenv REAL_REMOTEHOST `fqdn $HOST` \; $display_command_line \; detach xterm $xterm_options:q -ls
        else
          # don't bother detatching as ssh has to hold open the connection for
          # the X forwarding (run in a shell to put job# & PID into the log)
          csh -fc "$remote_sh $basic_command_line setenv REAL_REMOTEHOST `fqdn $HOST` \; '$display_command_line' \; xterm $xterm_options -ls &" >>& $CONSOLE
        endif
      endif
    endif
  endif
endif
