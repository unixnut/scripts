# These mirror the level contants defined in syslog(3), with extras
LOG_EMERG=0	# system is unusable
LOG_EMERGENCY=0	# ditto [non-standard]
LOG_PANIC=0	# ditto
LOG_ALERT=1	# action must be taken immediately
LOG_REDALERT=1	# ditto [non-standard]
LOG_CRIT=2	# critical conditions
LOG_CRITICAL=2	# ditto [non-standard]
LOG_ERR=3	# error conditions
LOG_ERROR=3	# ditto
LOG_WARNING=4	# warning conditions
LOG_WARN=4	# ditto
LOG_NOTICE=5	# normal but significant condition
LOG_INFO=6	# informational
LOG_DEBUG=7	# debug-level messages

if [ -n "$BASH_VERSION" ] ; then
  . "$SCRIPT_INCLUDE_DIR"/_log_levels_bash.sh
fi

# Hack for non-BASH
# E.g. 
#   level=$LOG_NOTICE
#   eval echo level: \$LOG_$level
LOG_0=Emergency
LOG_1=Red\ alert
LOG_2=Critical
LOG_3=Error
LOG_4=Warning
LOG_5=Notice
LOG_6=Info
LOG_7=Debug

# Not needed; numeric priority is supported
## # for use with logger(1)
## LOG_DESIGNATOR_0=emerg
## LOG_DESIGNATOR_1=alert
## LOG_DESIGNATOR_2=crit
## LOG_DESIGNATOR_3=err
## LOG_DESIGNATOR_4=warning
## LOG_DESIGNATOR_5=notice
## LOG_DESIGNATOR_6=info
## LOG_DESIGNATOR_7=debug
