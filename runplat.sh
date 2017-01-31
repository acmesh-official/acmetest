#!/usr/bin/env sh

DEFAULT_SCRIPT="letest.sh"

if [ -z "$RUN_SCRIPT" ] ; then
  RUN_SCRIPT="$DEFAULT_SCRIPT"
fi

export RUN_SCRIPT

if [ -z "$1" ] ; then
  echo "Usage: plat [head.md]"
  exit 1
fi

platname="$1"
if [ "$2" ] ; then
  filename="$2"
else
  filename="head.md"
fi


if [ -z "$LOG_FILE" ] ; then
  export LOG_FILE="$(./rundocker.sh _getLogfile "$platname" )"
  echo "" > "$LOG_FILE"
  export Log_Out="$(./rundocker.sh _getOutfile "$platname" )"
  echo "" > "$Log_Out"
fi

export CASE

if [ "$DEBUG" ]; then
  ./$RUN_SCRIPT
else
  ./$RUN_SCRIPT >> "$Log_Out" 2>&1
fi

_rplat_exit="$?"

./rundocker.sh  update "$platname" "$_rplat_exit" "$filename"



