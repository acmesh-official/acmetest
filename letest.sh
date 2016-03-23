#!/usr/bin/env bash

STAGE=1

lezip="https://github.com/Neilpang/le/archive"
legit="https://github.com/Neilpang/le.git"

Default_Home="$HOME/.le"

BEGIN_CERT="-----BEGIN CERTIFICATE-----"
END_CERT="-----END CERTIFICATE-----"

_err() {
  if [ -z "$2" ] ; then
    echo -e "$1" >&2
  else
    echo -e "$1=$2" >&2
  fi
}

_debug() {

  if [ -z "$DEBUG" ] ; then
    return
  fi
  
  if [ -z "$2" ] ; then
    echo $1
  else
    echo "$1"="$2"
  fi
}

_info() {
  if [ -z "$2" ] ; then
    echo -e "$1"
  else
    echo -e "$1=$2"
  fi
}


_ss() {
  _port="$1"
  
  if _exists "ss" ; then
    _debug "Using: ss"
    ss -ntpl | grep :$_port" "
    return 0
  fi

  if _exists "netstat" ; then
    _debug "Using: netstat"
    if netstat -h 2>&1 | grep "\-p proto" >/dev/null ; then
      #for windows version netstat tool
      netstat -anb -p tcp | grep "LISTENING" | grep :$_port" "
    else
      if netstat -help 2>&1 | grep "-p protocol" >/dev/null ; then
        netstat -an -p tcp | grep LISTEN | grep :$_port" "
      else
        netstat -ntpl | grep :$_port" "
      fi
    fi
    return 0
  fi

  return 1
}

SUDO="$(command -v sudo | grep -o 'sudo')"

if command -v yum > /dev/null ; then
 INSTALL="$SUDO yum install -y "
elif command -v apt-get > /dev/null ; then
 INSTALL="$SUDO apt-get install -y "
fi

__ok() {
  _info " [\u001B[32mPASS\u001B[0m]\t$1"
}
__fail() {
  _err " [\u001B[31mFAIL\u001B[0m]$1"
  return 1
}

#file
_assertcert() {
  filename="$1"
  echo -n "$filename is cert ? "
  if grep -- "$BEGIN_CERT" "$filename" >/dev/null 2>&1 \
  && grep -- "$END_CERT" "$filename" >/dev/null 2>&1 \
  && [ "$(cat "$filename" | wc -l )" -gt 2 ] ; then
    __ok ""
    return 0
  else
    __fail ""
    return 1
  fi
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
    if [ -f "account.key" ] && [ -d "$HOME/.le/" ] ; then
      cp account.key $HOME/.le/
      cp account.conf $HOME/.le/
    fi
  fi
  
  if ! $1 ; then
    _ret="1"
  fi
  
  rm -rf "$lehome/$TestingDomain"
  
  if [ -f "$lehome/le.sh" ] ; then
    $lehome/le.sh uninstall >/dev/null
    if [ ! -f "account.key" ] && [ -f "$lehome/account.key" ] ; then
      cp "$lehome/account.key" account.key
      cp "$lehome/account.conf" account.conf
    fi
  fi
  _info "------------------------------------------"
}

####################################################
_setup() {

  if [ -d le ] ; then
    rm -rf le 
  fi
  if [ ! "$BRANCH" ] ; then
    BRANCH="master"
  fi
  
  if command -v unzip > /dev/null ; then
    link="$lezip/$BRANCH.zip"
    curl -OL "$link" >/dev/null 2>&1
    unzip "$BRANCH.zip"  >/dev/null 2>&1
    mv "le-$BRANCH" le
  elif command -v git > /dev/null ; then
    rm -rf le
    git clone $legit -b $BRANCH
  else
    _err "Can not get le source code. Unzip or git must be installed"
    return 1
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
      echo -n "$cmd installed." 
      __ok
    else
      echo -n "$cmd not installed"
      __fail
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

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" || return
  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}

le_test_standandalone_SAN() {
  lehome="$Default_Home"

  lp=`_ss| grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and TestingAltDomains, and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain $TestingAltDomains" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" || return
  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"
}

le_test_standandalone_ECDSA_256() {
  lehome="$Default_Home"

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain no ec-256" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" || return
  
  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}


le_test_standandalone_ECDSA_384() {
  lehome="$Default_Home"

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is already used."
    return 1
  fi
  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _assertcmd "$lehome/le.sh issue no $TestingDomain no ec-384" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" || return
  
  lp=`_ss | grep ':80 '`
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
  if [ "$DEBUG" ] && [ "$_ret" != "0" ] ; then
    break;
  fi
done

exit $_ret

