# This array doesn't need to be associative because the above definitions are
# in continuously increasing numerical order.
# E.g. 
#   level=$LOG_NOTICE
#   echo level: ${LOG_LEVELS[$level]}
declare -a LOG_LEVELS LOG_LEVEL_NAMES
# "None" is a hack to make the array remaining indicies 1-based
LOG_LEVELS=(None Debug Info Notice Warning Error Critical Red\ alert Emergency)
# for use with logger(1)
LOG_LEVEL_NAMES=(none debug info notice warning err crit alert emerg)
