#!/usr/bin/env bash

STAGE=1

legit="https://github.com/Neilpang/le.git"


Default_Home="$HOME/.le"



_err() {
  if [ -z "$2" ] ; then
    echo -e "$1" >&2
  else
    echo -e "$1=$2" >&2
  fi
}


_info() {
  if [ -z "$2" ] ; then
    echo -e "$1"
  else
    echo -e "$1=$2"
  fi
}


SUDO="$(command -v sudo | grep -o 'sudo')"

if command -v yum > /dev/null ; then
 INSTALL="$SUDO yum install -y "
elif command -v apt-get > /dev/null ; then
 INSTALL="$SUDO apt-get install -y "
fi

if ! command -v git >/dev/null ; then
  _err "You must have git installed to run this test."
  _err "$INSTALL git"
  return 1
fi

__ok() {
  _info " [\u001B[32mPASS\u001B[0m]\t$1"
}
__fail() {
  _err " [\u001B[31mFAIL\u001B[0m]$1"
  return 1
}

#cmd
_assertcmd() {
  __cmd="$1"
  echo -n "$__cmd"
  if [ "$DEBUG" ] ; then
    $__cmd
  else
    $__cmd > /dev/null
  fi
  
  if [ "$?" == "0" ] ; then 
    __ok ""
  else
    __fail ""
    return 1
  fi
  return 0
}

#file
_assertexists() {
  __file="$1"
  if [ -e "$__file" ] ; then
    echo -n "$__file exists."
    __ok ""
  else
    echo -n "$__file missing."
    __fail ""
    return 1
  fi
  return 0
}

#file
_assertnotexists() {
  __file="$1"
  if [ ! -e "$__file" ] ; then
    echo -n "$__file no exists."
    __ok ""
  else
    echo -n "$__file is there."
    __fail ""
    return 1
  fi
  return 0
}

_assertequals() {
  if [ "$1" == "$2" ] ; then
    echo -n "equals $1"
    __ok ""
  else
    __fail "Failed"
    _err "Expected:$1"
    _err "But was:$2"
  fi
}

_run() {
  _info "===Running $1 please wait"
  lehome="$Default_Home"
  export STAGE
  export DEBUG
  
  if [ "$1" != "le_test_installtodir" ] && [ "$1" != "le_test_uninstalltodir" ] ; then
    cd le;
    ./le.sh install > /dev/null
    cd ..
  fi
  
  if ! $1 ; then
    _ret="$?"
  fi
  
  if [ -f "$lehome/le.sh" ] ; then
    $lehome/le.sh uninstall >/dev/null
  fi
  _info "------------------------------------------"
}

####################################################
_setup() {

  if [ -d le ] ; then
    rm le -rf
  fi
  if [ "$BRANCH" ] ; then
    git clone $legit -b $BRANCH > /dev/null 2>&1
  else
    git clone $legit  > /dev/null 2>&1
  fi
  
  lehome="$Default_Home"
  if [ -f "$lehome/le.sh" ] ; then
    $lehome/le.sh uninstall >/dev/null 2>&1
  fi
  
  if [ -d $Default_Home ] ; then 
    rm -rf $Default_Home
  fi
  

}


le_test_dependencies() {
  dependencies="curl crontab openssl nc"
  for cmd in $dependencies 
  do
    if command -v $cmd > /dev/null ; then
      _info "$cmd installed." 
    else
      _err "$cmd not installed"
      return 1
    fi
  done
}

le_test_install() {
  lehome="$Default_Home"
  
  cd le;
  _assertcmd  "./le.sh install" || return
  cd ..
  
  _assertexists "$lehome/le.sh" || return
  _assertequals "0 0 * * * LE_WORKING_DIR=\"$lehome\" \"$lehome\"/le.sh cron > /dev/null"  "$(crontab -l | grep le.sh)" || return
  _assertcmd "$lehome/le.sh uninstall  > /dev/null" ||  return
}

le_test_uninstall() {
  lehome="$Default_Home"
  cd le;
  _assertcmd  "./le.sh install" || return
  cd ..
  _assertcmd "$lehome/le.sh uninstall" ||  return
  _assertnotexists "$lehome/le.sh" ||  return
  _assertequals "" "$(crontab -l | grep le.sh)"||  return

}


le_test_installtodir() {
  lehome="$HOME/myle"
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  cd le;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./le.sh install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertexists "$lehome/le.sh" ||  return
  _assertequals "0 0 * * * LE_WORKING_DIR=\"$lehome\" \"$lehome\"/le.sh cron > /dev/null"  "$(crontab -l | grep le.sh)" ||  return
  _assertcmd "$lehome/le.sh uninstall" ||  return
}

le_test_uninstalltodir() {
  lehome="$HOME/myle"
  
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  
  cd le;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./le.sh install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertcmd "$lehome/le.sh uninstall" ||  return
  _assertnotexists "$lehome/le.sh" ||  return
  _assertequals "" "$(crontab -l | grep le.sh)" ||  return

}

#
le_test_standandalone() {
  lehome="$Default_Home"

  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain" ||  return
  
  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}

le_test_standandalone_SAN() {
  lehome="$Default_Home"

  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and TestingAltDomains, and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain $TestingAltDomains" ||  return
  
  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"
}

le_test_standandalone_ECDSA_256() {
  lehome="$Default_Home"

  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain no ec-256" ||  return
  
  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}


le_test_standandalone_ECDSA_384() {
  lehome="$Default_Home"

  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain no ec-384" ||  return
  
  lp=`ss -ntlp | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}


#####################################

BRANCH=$1

_setup

_ret=0

for t in $(typeset -F | grep -o 'le_test_.*') 
do
  _run "$t"
done

return $_ret

