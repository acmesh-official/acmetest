#!/usr/bin/env sh

STAGE=1

lezip="https://github.com/Neilpang/acme.sh/archive"
legit="https://github.com/Neilpang/acme.sh.git"

Default_Home="$HOME/.acme.sh"

PROJECT_ENTRY="acme.sh"


BEGIN_CERT="-----BEGIN CERTIFICATE-----"
END_CERT="-----END CERTIFICATE-----"

CA="Fake LE Intermediate X1"

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

_exists() {
  cmd="$1"
  if [ -z "$cmd" ] ; then
    _err "Usage: _exists cmd"
    return 1
  fi
  command -v $cmd >/dev/null 2>&1
  ret="$?"
  _debug "$cmd exists=$ret"
  return $ret
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
      if netstat -help 2>&1 | grep "\-p protocol" >/dev/null ; then
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

#file subname
_assertcert() {
  filename="$1"
  subname="$2"
  issuername="$3"
  echo -n "$filename is cert ? "
  subj="$(openssl x509  -in $filename  -text  -noout | grep 'Subject: CN=' | cut -d '=' -f 2 | cut -d / -f 1)"
  echo -n "$subj"
  if [[ "$subj" == "$subname" ]] ; then
    if [[ "$issuername" ]] ; then
      issuer="$(openssl x509  -in $filename  -text  -noout | grep 'Issuer: CN=' | cut -d '=' -f 2)"
      echo -n " $issuer"
      if [[ "$issuername" != "$issuer" ]] ; then
        __fail ""
        return 1
      fi
    fi
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
  
  eval "$__cmd > \"cmd.log\" 2>&1"
  
  if [ "$?" == "0" ] ; then 
    __ok ""
  else
    __fail ""
    if [ "$DEBUG" ] ; then
      cat "cmd.log" >&2
    fi
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
    cd acme.sh;
    ./$PROJECT_ENTRY install > /dev/null
    cd ..
    if [ -f "account.key" ] && [ -d "$HOME/.acme.sh/" ] ; then
      cp account.key $HOME/.acme.sh/
      cp account.conf $HOME/.acme.sh/
    fi
  fi
  
  if ! ( $1 ) ; then
    _ret="1"
  fi
  
  rm -rf "$lehome/$TestingDomain"
  
  if [ -f "$lehome/$PROJECT_ENTRY" ] ; then
    $lehome/$PROJECT_ENTRY uninstall >/dev/null
    if [ ! -f "account.key" ] && [ -f "$lehome/account.key" ] ; then
      cp "$lehome/account.key" account.key
      cp "$lehome/account.conf" account.conf
    fi
  fi
  _info "------------------------------------------"
}

####################################################
_setup() {

  if [ -d acme.sh ] ; then
    rm -rf acme.sh 
  fi
  if [ ! "$BRANCH" ] ; then
    BRANCH="master"
  fi
  
  if command -v tar > /dev/null ; then
    link="$lezip/$BRANCH.tar.gz"
    curl -OL "$link" >/dev/null 2>&1
    tar xzf "$BRANCH.tar.gz"  >/dev/null 2>&1
    mv "acme.sh-$BRANCH" acme.sh
  elif command -v git > /dev/null ; then
    rm -rf acme.sh
    git clone $legit -b $BRANCH
  else
    _err "Can not get acme.sh source code. tar or git must be installed"
    return 1
  fi
  lehome="$Default_Home"
  if [ -f "$lehome/$PROJECT_ENTRY" ] ; then
    $lehome/$PROJECT_ENTRY uninstall >/dev/null 2>&1
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
  
  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY install" || return
  cd ..
  
  _assertexists "$lehome/$PROJECT_ENTRY" || return
  _assertequals "0 0 * * * \"$lehome\"/$PROJECT_ENTRY --cron --home \"$lehome\" > /dev/null"  "$(crontab -l | grep $PROJECT_ENTRY)" || return
  _assertcmd "$lehome/$PROJECT_ENTRY uninstall  > /dev/null" ||  return
}

le_test_uninstall() {
  lehome="$Default_Home"
  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY install" || return
  cd ..
  _assertcmd "$lehome/$PROJECT_ENTRY uninstall" ||  return
  _assertnotexists "$lehome/$PROJECT_ENTRY" ||  return
  _assertequals "" "$(crontab -l | grep $PROJECT_ENTRY)"||  return

}


le_test_installtodir() {
  lehome="$HOME/myle"
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  cd acme.sh;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./$PROJECT_ENTRY install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertexists "$lehome/$PROJECT_ENTRY" ||  return
  _assertequals "0 0 * * * \"$lehome\"/$PROJECT_ENTRY --cron --home \"$lehome\" > /dev/null"  "$(crontab -l | grep $PROJECT_ENTRY)" ||  return
  _assertcmd "$lehome/$PROJECT_ENTRY uninstall" ||  return
}

le_test_uninstalltodir() {
  lehome="$HOME/myle"
  
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  
  cd acme.sh;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./$PROJECT_ENTRY install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertcmd "$lehome/$PROJECT_ENTRY uninstall" ||  return
  _assertnotexists "$lehome/$PROJECT_ENTRY" ||  return
  _assertequals "" "$(crontab -l | grep $PROJECT_ENTRY)" ||  return

}

#
le_test_standandalone_renew() {
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain" ||  return
   
  _assertcmd "FORCE=1 $lehome/$PROJECT_ENTRY renew $TestingDomain" ||  return

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}


#
le_test_standandalone_renew_v2() {
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

  _assertcmd "$lehome/$PROJECT_ENTRY --issue -d $TestingDomain --standalone" ||  return
   
  _assertcmd "$lehome/$PROJECT_ENTRY --renew -d $TestingDomain --force" ||  return
  
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain $TestingAltDomains" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain no ec-256" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}

le_test_standandalone_ECDSA_256_renew() {
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain no ec-256" ||  return

  _assertcmd "FORCE=1 $lehome/$PROJECT_ENTRY renew $TestingDomain" ||  return

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}


le_test_standandalone_ECDSA_256_SAN_renew() {
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain $TestingAltDomains ec-256" ||  return

  _assertcmd "FORCE=1 $lehome/$PROJECT_ENTRY renew $TestingDomain" ||  return

  lp=`_ss | grep ':80 '`
  if [ "$lp" ] ; then
    __fail "80 port is not released: $lp"
    return 1
  fi
  
  rm -rf "$lehome/$TestingDomain"

}

le_test_standandalone_ECDSA_256_SAN_renew_v2() {
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

  _assertcmd "$lehome/$PROJECT_ENTRY --issue -d $TestingDomain -d $TestingAltDomains --standalone --keylength ec-256" ||  return

  _assertcmd "$lehome/$PROJECT_ENTRY --renew -d $TestingDomain --force" ||  return
  
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
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

  _assertcmd "$lehome/$PROJECT_ENTRY issue no $TestingDomain no ec-384" ||  return
  _assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  _assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
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

