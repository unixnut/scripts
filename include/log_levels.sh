# These mirror the level contants defined in syslog(3), with extras
LOG_EMERG=8	# system is unusable
LOG_EMERGENCY=8	# ditto [non-standard]
LOG_PANIC=8	# ditto
LOG_ALERT=7	# action must be taken immediately
LOG_REDALERT=7	# ditto [non-standard]
LOG_CRIT=6	# critical conditions
LOG_CRITICAL=6	# ditto [non-standard]
LOG_ERR=5	# error conditions
LOG_ERROR=5	# ditto
LOG_WARNING=4	# warning conditions
LOG_WARN=4	# ditto
LOG_NOTICE=3	# normal but significant condition
LOG_INFO=2	# informational
LOG_DEBUG=1	# debug-level messages

if [ -n "$BASH_VERSION" ] ; then
  . "$SCRIPT_INCLUDE_DIR"/_log_levels_bash.sh
fi

# Hack for non-BASH
# E.g. 
#   level=$LOG_NOTICE
#   eval echo level: \$LOG_$level
LOG_8=Emergency
LOG_7=Red\ alert
LOG_6=Critical
LOG_5=Error
LOG_4=Warning
LOG_3=Notice
LOG_2=Info
LOG_1=Debug

# Not needed; numeric priority is supported
## # for use with logger(1)
## LOG_DESIGNATOR_8=emerg
## LOG_DESIGNATOR_7=alert
## LOG_DESIGNATOR_6=crit
## LOG_DESIGNATOR_5=err
## LOG_DESIGNATOR_4=warning
## LOG_DESIGNATOR_3=notice
## LOG_DESIGNATOR_2=info
## LOG_DESIGNATOR_1=debug
