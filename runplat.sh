#!/usr/bin/env sh


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


if [ -z "$DEBUG" ] ; then
  if type export >/dev/null ; then
    export CI=1
  else
    setenv CI 1
  fi
fi

if [ -z "$LOG_FILE" ] ; then
  export LOG_FILE="$(./rundocker.sh _getLogfile "$platname" )"
  echo "" > "$LOG_FILE"
  export Log_Out="$(./rundocker.sh _getOutfile "$platname" )"
  echo "" > "$Log_Out"
fi


./letest.sh >> "$Log_Out" 2>&1
_rplat_exit="$?"

./rundocker.sh  update "$platname" "$_rplat_exit" "$filename"



