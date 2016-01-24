#!/bin/bash

STAGE=1

legit="https://github.com/Neilpang/le.git"
assertsh="https://github.com/Neilpang/assert.sh.git"


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
  _info "[\u001B[32mPASS\u001B[0m]\t$1"
}
__fail() {
  _err "[\u001B[31mFAIL\u001B[0m]$1"
}

#cmd
_assertcmd() {
  __cmd="$1"
  if [ "DEBUG" ] ; then
    $__cmd
  else
    $__cmd > /dev/null
  fi
  
  if [ "$?" == "0" ] ; then 
    __ok "$__cmd"
  else
    __fail "$__cmd"
    return 1
  fi
  return 0
}

#file
_assertexists() {
  __file="$1"
  if [ -e "$__file" ] ; then
    __ok "$__file exists."
  else
    __fail "$__file missing."
    return 1
  fi
  return 0
}

#file
_assertnotexists() {
  __file="$1"
  if [ ! -e "$__file" ] ; then
    __ok "$__file no exists."
  else
    __fail "$__file is there."
    return 1
  fi
  return 0
}

_assertequals() {
  if [ "$1" == "$2" ] ; then
    __ok "OK!"
  else
    __fail "Failed!"
  fi
}

_run() {
  _info "==============Running $1=================="
  $1
  _info "------------------------------------------"
}

####################################################
_setup() {
  if [ -d assert ] ; then
    rm -rf assert
  fi
  
  git clone $assertsh 2>&1 > /dev/null
  source assert.sh/assert.sh
  if [ -d le ] ; then
    rm le -rf
  fi
  git clone $legit  2>&1 > /dev/null
  
  if [ -d ~/.le ] ; then 
    rm -rf ~/.le
  fi
}


le_test_dependencies() {
  dependencies="curl crontab openssl nc xxd"
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
  lehome="$HOME/.le"
  
  cd le;
  _assertcmd  "./le.sh install" || return
  cd ..
  
  _assertexists "$lehome/le.sh" || return
  _assertexists "$lehome/le" || return
  _assertexists "/usr/local/bin/le" || return
  _assertexists "/usr/local/bin/le.sh" || return
  _assertequals "$(crontab -l | grep le.sh)" "0 0 * * * $SUDO WORKING_DIR=\"$lehome\" \"$lehome\"/le.sh cron > /dev/null" || return

}

le_test_uninstall() {
  lehome="$HOME/.le"
  _assertcmd "$lehome/le.sh uninstall" ||  return
  _assertnotexists "$lehome/le.sh" ||  return
  _assertnotexists "$lehome/le" ||  return
  _assertnotexists "/usr/local/bin/le" ||  return
  _assertnotexists "/usr/local/bin/le.sh" ||  return
  _assertequals "$(crontab -l | grep le.sh)" "" ||  return

}


le_test_installtodir() {
  lehome="$HOME/myle"
  if [ -d ] ; then
    rm -rf lehome
  fi
  cd le;
   WORKING_DIR=$lehome
   export WORKING_DIR
  _assertcmd "./le.sh install" ||  return
  WORKING_DIR=""
  cd ..
  
  _assertexists "$lehome/le.sh" ||  return
  _assertexists "$lehome/le" ||  return
  _assertexists "/usr/local/bin/le" ||  return
  _assertexists "/usr/local/bin/le.sh" ||  return
  _assertequals "$(crontab -l | grep le.sh)" "0 0 * * * $SUDO WORKING_DIR=\"$lehome\" \"$lehome\"/le.sh cron > /dev/null" ||  return

}

le_test_uninstalltodir() {
  lehome="$HOME/myle"
  
  _assertcmd "$lehome/le.sh uninstall" ||  return
  _assertnotexists "$lehome/le.sh" ||  return
  _assertnotexists "$lehome/le" ||  return
  _assertnotexists "/usr/local/bin/le" ||  return
  _assertnotexists "/usr/local/bin/le.sh" ||  return
  _assertequals "$(crontab -l | grep le.sh)" "" ||  return

}



#####################################

_setup

_run le_test_dependencies

_run le_test_install

_run le_test_uninstall

_run le_test_installtodir

_run le_test_uninstalltodir



