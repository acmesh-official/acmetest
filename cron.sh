#!/usr/bin/env sh


if [ -z "$1" ] ; then
  echo "Usage: plat"
  exit 1
fi

plat="$1"

export  TestingDomain=test$plat.acme.sh
export  TestingAltDomains=test${plat}2.acme.sh

export CI=1

export RUN_SCRIPT

./runplat.sh  "$plat"


