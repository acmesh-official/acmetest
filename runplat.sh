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
  if type export ; then
    export CI=1
  else
    setenv CI 1
  fi
fi

./letest.sh

./rundocker.sh  update "$platname" $? "$filename"



