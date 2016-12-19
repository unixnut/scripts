if [ -z "$LOG_REDALERT" ] ; then
  if [ -z "$SCRIPT_INCLUDE_DIR" ] ; then
    # Hope that include/ is a subdir of the calling script's dir
    SCRIPT_INCLUDE_DIR=$(dirname "$0")/include
  fi
  . "$SCRIPT_INCLUDE_DIR"/log_levels.sh
fi


# == Preparation ==
if [ -z "$self" ] ; then
  echo 'logging.sh: $self not set' >&2
  exit 101
else
  syslog_tag="$self[$$]"
fi

if [ -z "$syslog_facility" ] ; then
  echo 'logging.sh: $syslog_facility not set' >&2
  exit 102
fi


# *** FUNCTIONS ***
# == Internal ==
# Wrapper function that takes a numeric arg.
# (Only logs if arg >= $min_log_level or the latter isn't set)
# Remaining args are passed to logger verbatim, including options (like -s).
# Usage: _log $LOG_XYZ [ -s ] -- "message"
_log()
{
  _level=$1
  shift

  if [ -z "$min_log_level" -o "$_level" -ge "$min_log_level" ] ; then
    # convert level to a token for logger(1)
    ## eval _log_designator=\$LOG_DESIGNATOR_$_level

    eval _level_name=\$LOG_$_level

    while [ "x$1" != x-- ] ; do
      _logger_opts="$_logger_opts $1"
      shift
    done
    shift

    logger -t $self -p $syslog_facility.$_level $_logger_opts -- $_level_name: "$@"
  fi
}


# == Public ==
# -- functions that log to syslog only --
syslog_emergency()
{
  _log $LOG_EMERGENCY -- "$*"
}


syslog_red_alert()
{
  _log $LOG_RED_ALERT -- "$*"
}


syslog_critical()
{
  _log $LOG_CRITICAL -- "$*"
}


syslog_error()
{
  _log $LOG_ERROR -- "$*"
}


syslog_warning()
{
  _log $LOG_WARNING -- "$*"
}


syslog_notice()
{
  _log $LOG_NOTICE -- "$*"
}


syslog_info()
{
  _log $LOG_INFO -- "$*"
}


syslog_debug()
{
  _log $LOG_DEBUG -- "$*"
}


# -- functions that log to stderr and syslog --
log_emergency()
{
  _log $LOG_EMERGENCY -s -- "$*"
}


log_red_alert()
{
  _log $LOG_REDALERT -s -- "$*"
}


log_critical()
{
  _log $LOG_CRITICAL -s -- "$*"
}


log_error()
{
  _log $LOG_ERROR -s -- "$*"
}


log_warning()
{
  _log $LOG_WARNING -s -- "$*"
}


log_notice()
{
  _log $LOG_NOTICE -s -- "$*"
}


log_info()
{
  _log $LOG_INFO -s -- "$*"
}


log_debug()
{
  _log $LOG_DEBUG -s -- "$*"
} 
