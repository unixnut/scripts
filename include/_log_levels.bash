# This array doesn't need to be associative because the above definitions are
# in continuously decreasing numerical order.
# E.g. 
#   level=$LOG_NOTICE
#   echo level: ${LOG_LEVELS[$level]}
declare -a LOG_LEVELS LOG_LEVEL_NAMES
# for use with logger(1)
LOG_LEVELS=(emerg alert crit err warning notice info debug)
LOG_LEVEL_NAMES=(Emergency Red\ alert Critical Error Warning Notice Info Debug)
