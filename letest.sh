#!/usr/bin/env sh

STAGE=1

lezip="https://github.com/acmesh-official/acme.sh/archive"
legit="https://github.com/acmesh-official/acme.sh.git"

PROJECT="https://github.com/acmesh-official/acmetest"

NGROK_WIKI="https://github.com/acmesh-official/acmetest"


DEFAULT_HOME="$HOME/.acme.sh"

PROJECT_ENTRY="acme.sh"
FILE_NAME="letest.sh"


ENV_FILE="./loadenv.sh"
if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
fi



BEGIN_CERT="-----BEGIN CERTIFICATE-----"
END_CERT="-----END CERTIFICATE-----"

if [ -z "$CA" ]; then
  CA="(STAGING)"
fi

if [ -z "$CA_ECDSA" ]; then
  CA_ECDSA="(STAGING)"
fi

if [ -z "$TEST_ACME_Server" ]; then
  export TEST_ACME_Server="letsencrypt_test"
fi


if [ "$TEST_CA" ]; then
  CA="$TEST_CA"
  CA_ECDSA="$TEST_CA"
fi




ECC_SEP="_"
ECC_SUFFIX="${ECC_SEP}ecc"

STAGE_CA="https://acme-staging.api.letsencrypt.org"

_API_HOST="$(echo "$STAGE_CA" | cut -d : -f 2 | tr -d '/')"




_isIPv4() {
  for seg in $(echo "$1" | tr '.' ' '); do
    if [ "$(echo "$seg" | tr -d [0-9])" ]; then
      #not all number
      return 1
    fi
    if [ $seg -ge 0 ] && [ $seg -lt 256 ]; then
      continue
    fi
    return 1
  done
  return 0
}

#ip6
_isIPv6() {
  _contains "$1" ":"
}

#ip
_isIP() {
  _isIPv4 "$1" || _isIPv6 "$1"
}



_startswith(){
  _str="$1"
  _sub="$2"
  echo "$_str" | grep -- "^$_sub" >/dev/null 2>&1
}

if [ -z "$LOG_FILE" ] ; then
  LOG_FILE="letest.log"
else
  if ! _startswith "$LOG_FILE" "/" ; then
    LOG_FILE="$(pwd)/$LOG_FILE"
    export LOG_FILE
  fi  
fi

export LOG_FILE

if [ -z "$LOG_LEVEL" ] ; then
  LOG_LEVEL=2
fi

export LOG_LEVEL


#we need color in travis
if [ "$TRAVIS" = "true" ] || [ "$GITHUB_REF" ]; then
  export ACME_FORCE_COLOR=1
elif [ "$CI" = "1" ]; then
  #In our cron testing server
  export ACME_NO_COLOR=1  
fi


__INTERACTIVE=""
if [ -t 1 ]; then
  __INTERACTIVE="1"
fi


__green() {
  if [ "${__INTERACTIVE}${ACME_NO_COLOR:-0}" = "10" -o "${ACME_FORCE_COLOR}" = "1" ]; then
    printf '\033[1;31;32m%b\033[0m' "$1"
    return
  fi
  printf -- "%b" "$1"
}

__red() {
  if [ "${__INTERACTIVE}${ACME_NO_COLOR:-0}" = "10" -o "${ACME_FORCE_COLOR}" = "1" ]; then
    printf '\033[1;31;40m%b\033[0m' "$1"
    return
  fi
  printf -- "%b" "$1"
}

__ok() {
  __green " [PASS]"
  printf "\n"
}



__fail() {
  __red " [FAIL] $1" >&2
  printf "\n" >&2
  return 1
}

_head_n() {
  head -n "$1"
}

_dlgVersions() {

  if _exists openssl ; then
    openssl version
  fi
  
  if _exists curl ; then
    curl -V
  fi
  
  if _exists wget ; then
    wget -V
  fi
}

_date_u () {
  date -u +"%a, %d %b %Y %T %Z"
}

#a + b
_math() {
  _m_opts="$@"
  printf "%s" "$(($_m_opts))"
}

_log() {
  if [ "$LOG_FILE" ] ; then
    echo "$@" >> "$LOG_FILE"
  fi
}

_info() {
  if [ -z "$2" ] ; then
    echo "$1"
    _log "$1"
  else
    echo "$1"="'$2'"
    _log "$1"="'$2'"
  fi
}

_err() {
  __red "$(_info "$@")\n" >&2
  return 1
}

_debug() {
  if [ -z "$DEBUG" ] ; then
    return
  fi
  _info "$@" >&2
  return 0
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

_contains() {
  _str="$1"
  _sub="$2"
  echo "$_str" | grep -- "$_sub" >/dev/null 2>&1
}

_mktemp() {
  if _exists mktemp; then
    if mktemp 2>/dev/null; then
      return 0
    elif _contains "$(mktemp 2>&1)" "-t prefix" && mktemp -t "$PROJECT_NAME" 2>/dev/null; then
      #for Mac osx
      return 0
    fi
  fi
  if [ -d "/tmp" ]; then
    echo "/tmp/${PROJECT_NAME}wefADf24sf.$(_time).tmp"
    return 0
  elif [ "$LE_TEMP_DIR" ] && mkdir -p "$LE_TEMP_DIR"; then
    echo "/$LE_TEMP_DIR/wefADf24sf.$(_time).tmp"
    return 0
  fi
  _err "Can not create temp file."
}

_egrep_o() {
  if ! egrep -o "$1" 2>/dev/null; then
    sed -n 's/.*\('"$1"'\).*/\1/p'
  fi
}

_ss() {
  _port="$1"
  
  if _exists "ss" ; then
    _debug "Using: ss"
    ss -ntpl | grep ":$_port "
    return 0
  fi

  if _exists "netstat" ; then
    _debug "Using: netstat"
    if netstat -h 2>&1 | grep "\-p proto" >/dev/null ; then
      #for windows version netstat tool
      netstat -anb -p tcp | grep "LISTENING" | grep ":$_port "
    else
      if netstat -help 2>&1 | grep "\-p protocol" >/dev/null ; then
        netstat -an -p tcp | grep LISTEN | grep ":$_port "
      elif netstat -help 2>&1 | grep -- '-P protocol' >/dev/null ; then
        #for solaris
        netstat -an -P tcp | grep "\.$_port " | grep "LISTEN"
      else
        netstat -ntpl | grep ":$_port "
      fi
    fi
    return 0
  fi

  return 1
}

#Usage: multiline
_base64() {
  if [ "$1" ] ; then
    openssl base64 -e
  else
    openssl base64 -e | tr -d '\r\n'
  fi
}

#Usage: hashalg  [outputhex]
#Output Base64-encoded digest
_digest() {
  alg="$1"
  if [ -z "$alg" ] ; then
    _usage "Usage: _digest hashalg"
    return 1
  fi
  
  outputhex="$2"
  
  if [ "$alg" = "sha256" ] ; then
    if [ "$outputhex" ] ; then
      echo $(openssl dgst -sha256 -hex | cut -d = -f 2)
    else
      openssl dgst -sha256 -binary | _base64
    fi
  else
    _err "$alg is not supported yet"
    return 1
  fi

}

_hasfield() {
  _str="$1"
  _field="$2"
  _sep="$3"
  if [ -z "$_field" ]; then
    _usage "Usage: str field  [sep]"
    return 1
  fi

  if [ -z "$_sep" ]; then
    _sep=","
  fi

  for f in $(echo "$_str" | tr "$_sep" ' '); do
    if [ "$f" = "$_field" ]; then
      _debug "'$_str' contains '$_field'"
      return 0 #contains ok
    fi
  done
  _debug "'$_str' does not contain '$_field'"
  return 1 #not contains
}


NGROK_MAC="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip"
NGROK_Linux="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
NGROK_Win="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip"
NGROK_BSD="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-freebsd-amd64.zip"


CF_Linux="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"
CF_MAC="https://github.com/cloudflare/cloudflared/releases/download/2022.10.3/cloudflared-darwin-amd64.tgz"
CF_Win="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe"




if [ -z "$TestingDomain" ]; then
    if [ -z "$CF_BIN" ] || [ ! -x "$CF_BIN" ]; then
      if _exists "cloudflared" ; then
        _info "Command cloudflared is found, so, use it."
        CF_BIN="cloudflared"
      else
        _os_name="$(uname)"
        _info _os_name "$_os_name"
        case "$_os_name" in
          CYGWIN_NT* | MINGW*)
            _debug "cygwin"
            export CF_BIN="$(pwd)/cloudflared.exe"
            CF_LINK="$CF_Win"
            ;;
          Linux)
            _debug "Linux"
            export CF_BIN="$(pwd)/cloudflared"
            CF_LINK="$CF_Linux"
            ;;
          Darwin)
            _debug "Darwin"
            export CF_BIN="$(pwd)/cloudflared"
            CF_LINK="$CF_MAC"
            ;;            
          *)
            _err "Not supported: $_os_name"
            exit 1
            ;;
        esac

        if [ ! -f "$CF_BIN" ]; then
          _info "Download from $CF_LINK"
          if [ "$CF_LINK" = "$CF_Linux" ]; then
            if ! curl -L "$CF_LINK" >"$CF_BIN"; then
              _err "Download error."
              exit 1
            fi
            chmod +x "$CF_BIN"
          elif [ "$CF_LINK" = "$CF_MAC" ]; then
            if ! curl -L "$CF_LINK" >cf.tgz; then
              _err "Download error."
              exit 1
            fi
 
            if ! tar -xzf cf.tgz; then
              _err "unzip error."
              exit 1
            fi

          else
            if ! curl -L "$CF_LINK" > cloudflared.exe; then
              _err "can not download: $latest_url"
              exit 1
            fi
            chmod +x "$CF_BIN"
          fi
        fi

        if [ ! -f "$CF_BIN" ]; then
          _err "Please install cloudflared command, or specify CF_BIN=$CF_BIN pointing to the ngrok binary. see: $NGROK_WIKI"
          exit 1
        fi
      fi
    fi

    ng_temp_1="cf.tmp"
    _info "ng_temp_1" "$ng_temp_1"
    $CF_BIN update
    if [ "$Le_HTTPPort" ]; then
      $CF_BIN tunnel --url http://localhost:$Le_HTTPPort >$ng_temp_1 2>&1 &
    else
      $CF_BIN tunnel --url http://localhost >$ng_temp_1 2>&1 &
    fi
    CF_PID="$!"
    _debug "cf pid: $CF_PID"
    
    MaxWait=60;#seconds
    _wait=0;
    while [ $_wait -le $MaxWait ]; do
      sleep 10
      _wait=$((_wait + 10))
      ng_domain_1="$(cat "$ng_temp_1" | grep https:// | grep trycloudflare.com | grep -v api.trycloudflare.com | head -1 | cut -d '|' -f 2 | tr -d ' ' | cut -d '/' -f 3)"
      _info "ng_domain_1" "$ng_domain_1"

      if [ -z "$ng_domain_1" ] ; then
        cat "$ng_temp_1"
        _err "Can not get cf domain."
        continue
      fi
      TestingDomain="$ng_domain_1"
      while ! grep "Generated Connector ID" "$ng_temp_1"; do
        _info "wait for connection to establish..."
        cat "$ng_temp_1"
        sleep 3
      done
      sleep 3
      cat "$ng_temp_1"
      break
    done;
    if [ -z "$TestingDomain" ] ; then
      cat "$ng_temp_1"
      _err "Can not get cf domain."
      exit 1
    fi
    #TEST_NGROK=1




#  if [ -z "$NGROK_TOKEN" ]; then
#    if [ -f "$USERPROFILE/.ngrok2/ngrok.yml" ]; then
#      #cygwin
#      NGROK_TOKEN=$(grep "authtoken:" "$USERPROFILE/.ngrok2/ngrok.yml" | cut -d : -f 2| tr -d " '")
#    fi
#    if [ -z "$NGROK_TOKEN" ] && [ -f "$HOME/.ngrok2/ngrok.yml" ]; then
#      #linux
#      NGROK_TOKEN=$(grep "authtoken:" "$HOME/.ngrok2/ngrok.yml" | cut -d : -f 2 | tr -d " '")
#    fi
#  fi
#  
#  if [ -z "$NGROK_TOKEN" ]; then
#    _err "The TestingDomain or TestingAltDomains is not specified, see: $PROJECT"
#    _err "You can also specify NGROK_TOKEN to test automatically, see: $NGROK_WIKI"
#    exit 1
#  fi
#
#  if [ "$NGROK_TOKEN" ]; then   
#    if [ -z "$NGROK_BIN" ] || [ ! -x "$NGROK_BIN" ]; then
#      if _exists "ngrok" ; then
#        _info "Command ngrok is found, so, use it."
#        NGROK_BIN="ngrok"
#      else
#        _os_name="$(uname)"
#        _info _os_name "$_os_name"
#        case "$_os_name" in
#          FreeBSD | OpenBSD)
#            _debug "BSD"
#            export NGROK_BIN="$(pwd)/ngrok"
#            NGROK_LINK="$NGROK_BSD"
#            ;;
#          CYGWIN_NT* | MINGW*)
#            _debug "cygwin"
#            export NGROK_BIN="$(pwd)/ngrok.exe"
#            NGROK_LINK="$NGROK_Win"
#            ;;
#          Linux)
#            _debug "Linux"
#            export NGROK_BIN="$(pwd)/ngrok"
#            NGROK_LINK="$NGROK_Linux"
#            ;;
#          Darwin)
#            _debug "Darwin"
#            export NGROK_BIN="$(pwd)/ngrok"
#            NGROK_LINK="$NGROK_MAC"
#            ;;            
#          *)
#            _err "Not supported: $_os_name"
#            exit 1
#            ;;
#        esac
#
#        if [ ! -f "$NGROK_BIN" ]; then
#          _info "Download from $NGROK_LINK"
#          if ! curl "$NGROK_LINK" >ngrok.zip; then
#            _err "Download error."
#            exit 1
#          fi
#          if ! unzip ngrok.zip; then
#            _err "unzip error."
#            exit 1
#          fi
#        fi
#
#        if [ ! -f "$NGROK_BIN" ]; then
#          _err "The NGROK_TOKEN is specified, it seems that you want to use ngrok to test, but the executable ngrok is not found."
#          _err "Please install ngrok command, or specify NGROK_BIN=$NGROK_BIN pointing to the ngrok binary. see: $NGROK_WIKI"
#          exit 1
#        fi
#      fi
#    fi
#    
#    _info "Using ngrok, register auth token first."
#    if ! $NGROK_BIN authtoken "$NGROK_TOKEN" ; then
#      _err "Register ngrok auth token failed."
#      exit 1
#    fi
#    
#    ng_temp_1="ngrok.tmp"
#    _info "ng_temp_1" "$ng_temp_1"
#    if [ "$Le_HTTPPort" ]; then
#      $NGROK_BIN http $Le_HTTPPort --log stdout --log-format logfmt --log-level debug > "$ng_temp_1" &
#    else
#      $NGROK_BIN http 80 --log stdout --log-format logfmt --log-level debug > "$ng_temp_1" &
#    fi
#    NGROK_PID="$!"
#    _debug "ngrok pid: $NGROK_PID"
#    
#    sleep 20
#    
#    ng_domain_1="$(_egrep_o 'Hostname:.+.ngrok.io' <"$ng_temp_1" | _head_n 1 | cut -d':' -f2)"
#    _info "ng_domain_1" "$ng_domain_1"
#    
#    if [ -z "$ng_domain_1" ] ; then
#      cat "$ng_temp_1"
#      _err "Can not get ngrok domain."
#      exit 1
#    fi
#    TestingDomain="$ng_domain_1"
#    TEST_NGROK=1
#  fi
fi

if [ -z "$TestingDomain" ] && [ -z "$TEST_DNS" ]; then
  _err "The TestingDomain or TestingAltDomains is not specified, see: $PROJECT"
  _err "You can also specify NGROK_TOKEN to test automatically, see: $NGROK_WIKI"
  exit 1
fi

if [ "$TEST_IDN" ] ; then
  if [ -z "$TestingIDNDomain" ] ; then
    TestingIDNDomain="中$TestingDomain"
  fi
fi


if [ "$DOCKER_OS" = "centos:5" ] \
 || [ "$DOCKER_OS" = "gentoo/stage3" ] ; then
 NO_ECC_CASES="1"
 if ! grep "insecure" ~/.curlrc >/dev/null 2>&1; then
   echo insecure >>~/.curlrc
 fi
 NO_HMAC_CASES="1"
 TEST_DNS=""
fi 



#file subname issuername
_assertcert() {
  filename="$1"
  subname="$2"
  issuername="$3"
  printf "$filename is cert ? "
  subj="$(echo  $(openssl x509  -in $filename  -text  -noout | grep 'Subject:.*CN *=' | _egrep_o  " CN *=.*" | cut -d '=' -f 2 | cut -d / -f 1))"
  if [ -z "$subj" ]; then
    #empty subject, let's try dns alt names.
    subj="$(echo \"$(openssl x509  -in $filename  -text  -noout | grep ' *DNS:' | tr -d ' '),\" | _egrep_o "DNS:$subname," | sed 's/DNS://g' | tr -d ,)"
  fi
  printf "'$subj'"
  if _contains "$subj" "$subname" || _isIP "$subname"; then
    if [ "$issuername" ] ; then
      issuer="$(echo $(openssl x509 -in $filename -text -noout | grep 'Issuer:' | _egrep_o "CN *=[^,]*" | cut -d = -f 2))"
      printf " '$issuer'"
      if ! _contains "$issuer" "$issuername"; then
        __fail "Expected issuer is: '$issuername', but was: '$issuer'"
        return 1
      fi
    fi
    __ok ""
    return 0
  else
    __fail "Expected subject is: '$subname', but was: '$subj'"
    return 1
  fi
}

#cmd
#The command output goes to cmd.log while it runs. Without a timeout, a
#command that blocks forever (e.g. a curl call the server never answers)
#would hang until the CI job is killed and cmd.log would be lost with the
#container, leaving no clue at all (issue #4145). So kill the command after
#LE_CMD_TIMEOUT seconds (default 1 hour) and dump cmd.log.
_assertcmd() {
  __cmd="$1"
  printf "%s" "$__cmd"

  eval "$__cmd > \"cmd.log\" 2>&1 &"
  __cmd_pid=$!
  __cmd_waited=0
  __cmd_timeout="${LE_CMD_TIMEOUT:-3600}"
  while kill -0 "$__cmd_pid" 2>/dev/null; do
    if [ "$__cmd_waited" -ge "$__cmd_timeout" ]; then
      kill "$__cmd_pid" 2>/dev/null
      sleep 3
      kill -9 "$__cmd_pid" 2>/dev/null
      wait "$__cmd_pid" 2>/dev/null
      __fail "timed out after $__cmd_timeout seconds"
      cat "cmd.log" >&2
      return 1
    fi
    sleep 5
    __cmd_waited=$((__cmd_waited + 5))
  done
  wait "$__cmd_pid"
  if [ "$?" = "0" ] ; then
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
    printf "$__file exists."
    __ok ""
  else
    printf "$__file missing."
    __fail ""
    return 1
  fi
  return 0
}

#file
_assertnotexists() {
  __file="$1"
  if [ ! -e "$__file" ] ; then
    printf "$__file no exists."
    __ok ""
  else
    printf "$__file is there."
    __fail ""
    return 1
  fi
  return 0
}

_assertequals() {
  if [ "$1" = "$2" ] ; then
    printf "equals $1"
    __ok ""
  else
    __fail "Failed"
    _err "Expected:$1"
    _err "But was:$2"
  fi
}

#file1 file2
_assertfileequals(){
  file1="$1"
  file2="$2"
  if [ "$(cat "$file1" | _digest  sha256)" = "$(cat "$file2" | _digest  sha256)" ] ; then
    printf -- "'$file1' equals '$2'"
    __ok
  else
    __fail "Failed"
  fi
}

_run() {
  _test="$1"
  _info "==Running $_test please wait"
  lehome="$DEFAULT_HOME"
  export STAGE
  export DEBUG
  
  if [ "$_test" != "le_test_installtodir" ] && [ "$_test" != "le_test_uninstalltodir" ] && [ "$_test" != "le_test_install_config_home" ]; then
    cd acme.sh;
    ./$PROJECT_ENTRY install > /dev/null
    cd ..
  fi
  
  _r="0"
  __CASE_SKIPPED=""
  if ! ( $_test ) ; then
    _r="1"
  fi
  if [ "$_r" = "0" ]; then
    _debug "Run Success"
  else
    _err "Run Failed"
  fi
  DEFAULT_CA_HOME="$lehome/ca"

  if [ -z "$CA_HOME" ] ; then
    CA_HOME="$DEFAULT_CA_HOME"
  fi
    
  CA_DIR="$CA_HOME/$_API_HOST"

  if _contains "$_test" "SAN"; then
    _deactivateDomains="$TestingDomain$TestingAltDomains"
  else
    _deactivateDomains="$TestingDomain"
  fi
  _debug "_deactivateDomains" "$_deactivateDomains"
  if [ ! "$DEBUG" ] ; then
    rm -rf "$lehome/$TestingDomain"
    rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"
    if [ -f "$lehome/$PROJECT_ENTRY" ] ; then
      if [ -z "$__CASE_SKIPPED" ] && [ -f "$CA_DIR/account.key" ] ; then
        $lehome/$PROJECT_ENTRY --deactivate -d "$_deactivateDomains" >deactivate.log 2>&1
      fi
      __dr="$?"
      if [ "$__dr" != "0" ]; then
        _err "deactivate failed"
        cat deactivate.log
      fi
      if [ "$_r" = "0" ] ; then
        _r="$__dr"
      fi
      $lehome/$PROJECT_ENTRY --uninstall >/dev/null
    fi
  else
    if [ -f "$CA_DIR/account.key" ] ; then
      $lehome/$PROJECT_ENTRY --deactivate -d "$_deactivateDomains" >/dev/null 2>&1
    fi
  fi
  rm -f "$lehome/account.conf"
  _debug "_r" "$_r"
  _info "------------------------------------------"
  return $_r
}

####################################################
_setup() {
  if [ "$TEST_LOCAL" = "1" ] ; then
    _info "TEST_LOCAL skip setup."
    return 0
  fi
  if [ -d acme.sh ] ; then
    rm -rf acme.sh 
  fi
  if [ ! "$BRANCH" ] ; then
    BRANCH="dev"
  fi
  _info "Testing branch: $BRANCH"
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
  lehome="$DEFAULT_HOME"
  if [ -f "$lehome/$PROJECT_ENTRY" ] ; then
    $lehome/$PROJECT_ENTRY --uninstall >/dev/null 2>&1
  fi
  
  if [ -d $DEFAULT_HOME ] ; then 
    rm -rf $DEFAULT_HOME
  fi
  
  #reuse ca account keys for the low acount rate limit
  if [ -d "ca" ]; then
    mkdir -p "$DEFAULT_HOME"
    cp -r ca "$DEFAULT_HOME/"
    rm -f "$DEFAULT_HOME/ca/*/ca.conf"
  fi

}


le_test_dependencies() {
  dependencies="curl crontab openssl"
  for cmd in $dependencies 
  do
    if command -v $cmd > /dev/null ; then
      printf "$cmd installed." 
      __ok
    else
      printf "$cmd not installed"
      __fail
      return 1
    fi
  done
  if command -v socat > /dev/null ; then
      printf "$cmd installed." 
      __ok
  else
    if command -v python > /dev/null ; then
      printf "python installed." 
      __ok
      return
    fi
    if command -v python3 > /dev/null ; then
      printf "python3 installed." 
      __ok
      return
    fi
    if command -v python2 > /dev/null ; then
      printf "python2 installed." 
      __ok
      return
    fi
    printf "python not installed"
    __fail
    return 1
  fi
}

le_test_install() {
  lehome="$DEFAULT_HOME"
  
  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY --install" || return
  cd ..
  
  _assertexists "$lehome/$PROJECT_ENTRY" || return
  _c_entry="$(crontab -l | grep $PROJECT_ENTRY)"
  _assertcmd "_contains '$_c_entry' '\\* \\* \\* \"$lehome\"/$PROJECT_ENTRY --cron --home \"$lehome\" > /dev/null'" || return
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall  > /dev/null" ||  return
}

le_test_uninstall() {
  lehome="$DEFAULT_HOME"
  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY --install" || return
  cd ..
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall" ||  return
  _assertnotexists "$lehome/$PROJECT_ENTRY" ||  return
  _assertequals "" "$(crontab -l | grep $PROJECT_ENTRY)"||  return

}

le_test_install_completion() {
  lehome="$DEFAULT_HOME"

  if [ ! -f "acme.sh/$PROJECT_ENTRY.completion" ]; then
    _info "Skipped, no $PROJECT_ENTRY.completion in this branch"
    __CASE_SKIPPED="1"
    return 0
  fi

  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY --install" || return
  cd ..

  _assertexists "$lehome/$PROJECT_ENTRY.completion" || return
  _assertcmd "grep '$PROJECT_ENTRY.completion' '$lehome/$PROJECT_ENTRY.env' > /dev/null" || return
  #the completion file must be a no-op when sourced by a non-bash shell
  _assertcmd "sh -c '. \"$lehome/$PROJECT_ENTRY.completion\"' > /dev/null 2>&1" || return
  if _exists bash; then
    _assertcmd "bash -n \"$lehome/$PROJECT_ENTRY.completion\"" || return
    __completion_out="$(bash -c ". '$lehome/$PROJECT_ENTRY.completion'; COMP_WORDS=($PROJECT_ENTRY --insta); COMP_CWORD=1; _acme_sh_completion; echo \"\${COMPREPLY[*]}\"")"
    case "$__completion_out" in
    *--install-cronjob*)
      printf "completion candidates: '%s'" "$__completion_out"
      __ok
      ;;
    *)
      __fail "completion candidates wrong: '$__completion_out'"
      return 1
      ;;
    esac
  fi
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall  > /dev/null" ||  return
  _assertnotexists "$lehome/$PROJECT_ENTRY.completion" ||  return
}


le_test_installtodir() {
  lehome="$HOME/myle"
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  cd acme.sh;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./$PROJECT_ENTRY --install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertexists "$lehome/$PROJECT_ENTRY" ||  return
  _c_entry="$(crontab -l | grep $PROJECT_ENTRY)"
  _assertcmd "_contains '$_c_entry' '\\* \\* \\* \"$lehome\"/$PROJECT_ENTRY --cron --home \"$lehome\" > /dev/null'" || return
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall" ||  return
  if [ -z "$DEBUG" ]; then
    rm -rf $lehome
  fi
}

le_test_uninstalltodir() {
  lehome="$HOME/myle"
  
  if [ -d $lehome ] ; then
    rm -rf $lehome
  fi
  
  cd acme.sh;
  LE_WORKING_DIR=$lehome
  export LE_WORKING_DIR
  _assertcmd "./$PROJECT_ENTRY --install" ||  return
  LE_WORKING_DIR=""
  cd ..
  
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall" ||  return
  _assertnotexists "$lehome/$PROJECT_ENTRY" ||  return
  _assertequals "" "$(crontab -l | grep $PROJECT_ENTRY)" ||  return
  if [ -z "$DEBUG" ]; then
    rm -rf $lehome
  fi
}

le_test_install_config_home() {
  lehome="$DEFAULT_HOME"
  confighome="$HOME/etc/acme"
  
  cd acme.sh;
  _assertcmd  "./$PROJECT_ENTRY --install --config-home $confighome" || return
  cd ..
  
  _assertexists "$lehome/$PROJECT_ENTRY" || return
  _c_entry="$(crontab -l | grep $PROJECT_ENTRY)"
  _assertcmd "_contains '$_c_entry' '\\* \\* \\* \"$lehome\"/$PROJECT_ENTRY --cron --home \"$lehome\" --config-home \"$confighome\" > /dev/null'" || return
  _assertexists "$confighome/account.conf" || return
  _assertnotexists "$lehome/account.conf" || return
  _assertcmd "$lehome/$PROJECT_ENTRY --cron --config-home $confighome > /dev/null" ||  return
  _assertcmd "$lehome/$PROJECT_ENTRY --uninstall --config-home $confighome > /dev/null" ||  return
  _assertexists "$confighome/account.conf" || return
  _assertnotexists "$lehome/account.conf" || return
  if [ -z "$DEBUG" ]; then
    rm -rf "$confighome"
  fi
}


#
le_test_standandalone_renew_v2() {
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  certdir="$(pwd)/certs"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  
  #_assertfileequals "$lehome/$TestingDomain/$TestingDomain.cer" "$cert" ||  return
  #_assertfileequals "$lehome/$TestingDomain/$TestingDomain.key" "$key" ||  return
  #_assertfileequals "$lehome/$TestingDomain/ca.cer" "$ca" ||  return
  #_assertfileequals "$lehome/$TestingDomain/fullchain.cer" "$full" ||  return

  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" ||  return
  
  #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
  #_assertfileequals "$lehome/$TestingDomain/$TestingDomain.cer" "$cert" ||  return
  #_assertfileequals "$lehome/$TestingDomain/$TestingDomain.key" "$key" ||  return
  #_assertfileequals "$lehome/$TestingDomain/ca.cer" "$ca" ||  return
  #_assertfileequals "$lehome/$TestingDomain/fullchain.cer" "$full" ||  return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi
  rm -rf "$certdir"
  


}


#
le_test_standandalone_renew_localaddress_v2() {

  lehome="$DEFAULT_HOME"


  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  certdir="$(pwd)/certs"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone --local-address 0.0.0.0 --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    return 0
  fi
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" ||  return
  

  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi
  rm -rf "$certdir"
  

}


#
le_test_standandalone_listen_v4_v2() {
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  certdir="$(pwd)/certs"
  rm -rf "$certdir"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone --listen-v4 --cert-file '$cert' --key-file '$key'  --ca-file '$ca'  --reloadcmd 'echo this is reload'  --fullchain-file  '$full'" ||  return
  
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    return 0
  fi
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" ||  return
  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi
  rm -rf "$certdir"
  


}


#
le_test_standandalone_listen_v6_v2() {
  if [ -z "$TEST_IPV6" ] ; then
    _info "Skipped by TEST_IPV6"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  certdir="$(pwd)/certs"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone --listen-v6 --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    return 0
  fi
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" ||  return
  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi
  
  rm -rf "$certdir"
  


}

#
le_test_standandalone_deactivate_v2() {
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  
  certdir="$(pwd)/certs"
  rm -rf "$certdir"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --deactivate -d $TestingDomain" ||  return
  


}


#RFC 8555 sec 7.3.5 account key rollover: --update-account-key must switch
#the account to a new key that still maps to the SAME account on the CA.
le_test_update_account_key() {
  lehome="$DEFAULT_HOME"

  #only some CAs implement keyChange: LE staging and Pebble do; ZeroSSL and
  #ssl.com return errors and step-ca does not expose the url (PR 7080).
  _uak_server="$(echo "$TEST_ACME_Server" | tr '[A-Z]' '[a-z]')"
  _uak_supported=""
  case "$_uak_server" in
  letsencrypt_test | letsencrypt.org_test | https://acme-staging-v02.api.letsencrypt.org/directory | https://localhost:14000/dir)
    _uak_supported="1"
    ;;
  esac
  if [ -z "$_uak_supported" ]; then
    _info "Skipped: $TEST_ACME_Server does not support account key rollover"
    __CASE_SKIPPED="1"
    return 0
  fi

  #skip on acme.sh branches that do not have the feature yet
  if ! grep -- "--update-account-key" "$lehome/$PROJECT_ENTRY" >/dev/null 2>&1; then
    _info "Skipped: this acme.sh has no --update-account-key"
    __CASE_SKIPPED="1"
    return 0
  fi

  #make sure the account exists and capture its thumbprint
  _assertcmd "$lehome/$PROJECT_ENTRY --register-account --server \"$TEST_ACME_Server\"" || return
  _uak_print_old="$(sed -n "s/.*ACCOUNT_THUMBPRINT='\([^']*\)'.*/\1/p" cmd.log | _head_n 1)"
  _debug "_uak_print_old" "$_uak_print_old"
  if [ -z "$_uak_print_old" ]; then
    __fail "Cannot get the account thumbprint from --register-account"
    return 1
  fi

  _assertcmd "$lehome/$PROJECT_ENTRY --update-account-key --server \"$TEST_ACME_Server\"" || return
  _uak_print_new="$(sed -n "s/.*ACCOUNT_THUMBPRINT='\([^']*\)'.*/\1/p" cmd.log | _head_n 1)"
  _debug "_uak_print_new" "$_uak_print_new"
  if [ -z "$_uak_print_new" ]; then
    __fail "Cannot get the account thumbprint after the rollover"
    return 1
  fi
  if [ "$_uak_print_new" = "$_uak_print_old" ]; then
    __fail "The account thumbprint did not change after the rollover"
    return 1
  fi

  #the temporary new-key file must not survive the rollover
  if find "$lehome/ca" -name "account.key.new" 2>/dev/null | grep . >/dev/null; then
    __fail "A temporary account.key.new file was left behind"
    return 1
  fi

  #the rolled key must map to the SAME account: newAccount with it returns
  #the existing account (200), not a fresh registration (201)
  _assertcmd "$lehome/$PROJECT_ENTRY --register-account --server \"$TEST_ACME_Server\"" || return
  if ! grep "Already registered" cmd.log >/dev/null 2>&1; then
    __fail "The rolled key did not map to the existing account"
    return 1
  fi
  _uak_print_reg="$(sed -n "s/.*ACCOUNT_THUMBPRINT='\([^']*\)'.*/\1/p" cmd.log | _head_n 1)"
  _assertText "$_uak_print_new" "$_uak_print_reg" || return

  #Boulder staging may keep verifying kid-signed requests against the OLD
  #key for a few seconds after keyChange (WFE account cache / DB replica
  #lag): the next signed request gets 400 "JWS verification error" and the
  #same request succeeds seconds later. Poll a cheap kid-signed request
  #(--update-account) until the rolled key is live, so that the following
  #test cases are not hit by the stale-key window.
  _uak_maxwait=30 #seconds
  _uak_wait=0
  while [ $_uak_wait -le $_uak_maxwait ]; do
    if "$lehome/$PROJECT_ENTRY" --update-account --server "$TEST_ACME_Server" >/dev/null 2>&1; then
      break
    fi
    _info "The rolled key is not active yet, waiting 3 seconds"
    sleep 3
    _uak_wait=$((_uak_wait + 3))
  done
  if [ $_uak_wait -gt $_uak_maxwait ]; then
    __fail "The rolled account key did not become active within $_uak_maxwait seconds"
    return 1
  fi
}


le_test_standandalone_SAN() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  lehome="$DEFAULT_HOME"


  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and TestingAltDomains, and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" -d \"$TestingAltDomains\" --standalone" ||  return

  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    rm -f $lehome/${TestingDomain}*/$TestingDomain.key
    rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
  fi
  
  
}

le_test_standandalone_ECDSA_256_renew() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  
  if [ "$NO_ECC_CASES" ] ; then
    _info "Skipped by NO_ECC_CASES"
    __CASE_SKIPPED="1"
    return 0
  fi
    
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"
 
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone -k ec-256" ||  return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$TestingDomain" "$CA_ECDSA" || return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$CA_ECDSA" || return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc" ||  return
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key"
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.csr"
  fi

  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force --ecc" ||  return


  
  

}

le_test_standandalone_ECDSA_256_SAN_renew_v2() {
  if [ "$NO_ECC_CASES" ] ; then
    _info "Skipped by NO_ECC_CASES"
    __CASE_SKIPPED="1"
    return 0
  fi 
  
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"
  
  certdir="$(pwd)/certs"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  
  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" -d \"$TestingAltDomains\" --standalone --keylength ec-256 --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$cert" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key" "$key" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$ca" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/fullchain.cer" "$full" ||  return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc" ||  return
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key"
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.csr"
  fi
  
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" --ecc -d \"$TestingDomain\" --force" ||  return
  
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$TestingDomain" "$CA_ECDSA" || return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$CA_ECDSA" || return
  
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$cert" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key" "$key" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$ca" ||  return
  _assertfileequals "$lehome/$TestingDomain$ECC_SUFFIX/fullchain.cer" "$full" ||  return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc"||  return
  fi


}

le_test_standandalone_ECDSA_384() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  
  if [ "$NO_ECC_CASES" ] ; then
    _info "Skipped by NO_ECC_CASES"
    __CASE_SKIPPED="1"
    return 0
  fi

  if [ "$NO_ECC_384" ] ; then
    _info "Skipped by NO_ECC_384"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"
  
  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue --standalone -d \"$TestingDomain\" -k ec-384" ||  return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$TestingDomain" "$CA_ECDSA" || return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$CA_ECDSA" || return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc" ||  return
  fi


}

#
le_test_standandalone_renew_idn_v2() {
  if [ -z "$TEST_IDN" ] ; then
    _info "Skipped by TEST_IDN"
    __CASE_SKIPPED="1"
    return 0
  fi
  
  lehome="$DEFAULT_HOME"


  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _test_idn="$TestingIDNDomain"
  rm -rf "$lehome/$_test_idn"
  rm -rf "$lehome/$_test_idn$ECC_SUFFIX"

  certdir="$(pwd)/certs"
  mkdir -p "$certdir"
  cert="$certdir/domain.cer"
  key="$certdir/domain.key"
  ca="$certdir/ca.cer"
  full="$certdir/full.cer"
  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d $_test_idn --standalone --certpath '$cert' --keypath '$key'  --capath '$ca'  --reloadcmd 'echo this is reload'  --fullchainpath  '$full'" ||  return
  
  _assertfileequals "$lehome/$_test_idn/$_test_idn.cer" "$cert" ||  return
  _assertfileequals "$lehome/$_test_idn/$_test_idn.key" "$key" ||  return
  _assertfileequals "$lehome/$_test_idn/ca.cer" "$ca" ||  return
  _assertfileequals "$lehome/$_test_idn/fullchain.cer" "$full" ||  return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $_test_idn" ||  return
    rm -f "$lehome/${_test_idn}*/$_test_idn.key"
    rm -f "$lehome/${_test_idn}*/$_test_idn.csr"
  fi
  
  rm -rf "$certdir"
  mkdir -p "$certdir"
  
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $_test_idn --force" ||  return
  
  _assertcert "$lehome/$_test_idn/$_test_idn.cer" "$(idn $_test_idn)" "$CA" || return
  _assertcert "$lehome/$_test_idn/ca.cer" "$CA" || return
  
  _assertfileequals "$lehome/$_test_idn/$_test_idn.cer" "$cert" ||  return
  _assertfileequals "$lehome/$_test_idn/$_test_idn.key" "$key" ||  return
  _assertfileequals "$lehome/$_test_idn/ca.cer" "$ca" ||  return
  _assertfileequals "$lehome/$_test_idn/fullchain.cer" "$full" ||  return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $_test_idn" ||  return
  fi
  
  rm -rf "$certdir"



}


#test the --nginx mode: the workflow prepares a server block with an
#aaPanel/BT style "location ^~ /" proxy block, which shadows plain regex
#locations, see https://github.com/acmesh-official/acme.sh/issues/6125
le_test_nginx() {
  if [ -z "$TEST_NGINX" ]; then
    _info "Skipped by TEST_NGINX"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"

  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  if ! command -v nginx >/dev/null 2>&1; then
    __fail "nginx is not installed."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\" --issue -d $TestingDomain --nginx" || return

  #the injected challenge location must be removed after issuance
  if grep -r "ACME_NGINX_START" /etc/nginx/ ; then
    __fail "The nginx config was not restored after issuance."
    return 1
  fi

  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" || return

  if grep -r "ACME_NGINX_START" /etc/nginx/ ; then
    __fail "The nginx config was not restored after renewal."
    return 1
  fi

  _assertcmd "nginx -t" || return

}


#test the --apache mode: acme.sh appends a global Alias for the challenge
#dir to the main Apache config and must restore the config afterwards
le_test_apache() {
  if [ -z "$TEST_APACHE" ]; then
    _info "Skipped by TEST_APACHE"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"

  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  _apachectl="apachectl"
  if ! command -v apachectl >/dev/null 2>&1; then
    _apachectl="apache2ctl"
    if ! command -v apache2ctl >/dev/null 2>&1; then
      __fail "apachectl/apache2ctl is not installed."
      return 1
    fi
  fi

  _apacheconf="$($_apachectl -V | grep SERVER_CONFIG_FILE= | cut -d = -f 2 | tr -d '"')"
  case "$_apacheconf" in
    /*) ;;
    *) _apacheconf="$($_apachectl -V | grep HTTPD_ROOT= | cut -d = -f 2 | tr -d '"')/$_apacheconf" ;;
  esac
  if [ ! -f "$_apacheconf" ]; then
    __fail "Cannot find the Apache config file."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\" --issue -d $TestingDomain --apache" || return

  #the appended Alias must be removed from the config after issuance
  if grep "acme-challenge" "$_apacheconf" ; then
    __fail "The Apache config was not restored after issuance."
    return 1
  fi

  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force" || return

  if grep "acme-challenge" "$_apacheconf" ; then
    __fail "The Apache config was not restored after renewal."
    return 1
  fi

  _assertcmd "$_apachectl -t" || return

}


le_test_dnsapi() {
  if [ -z "$TEST_DNS" ]; then
    _info "Skipped by TEST_DNS"
    __CASE_SKIPPED="1"
    return 0
  fi
  _debug "$dnsapi"
  api=$TEST_DNS
  _debug api "$api"
  if [ "$NO_HMAC_CASES" = "1" ] && [ "$api" = "dns_aws" ]; then
    _info "Skipped for NO_HMAC_CASES"
    return 0
  fi

  d_sleep=$TEST_DNS_SLEEP

  if [ "$TEST_DNS_NO_WILDCARD" != "1" ]; then
    (
    _info "Testing wildcard domain. "
    _info "TestingDomain" "$TestingDomain"
    lehome="$DEFAULT_HOME"
    rm -rf "$lehome/$TestingDomain"
    rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

    _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" -d \"*.$TestingDomain\" --dns $api --dnssleep \"$d_sleep\" " ||  return
    
    #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
    #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
    _assertcmd "$lehome/$PROJECT_ENTRY --deactivate -d \"$TestingDomain\" >/dev/null 2>&1"
    
    if [ -z "$NO_REVOKE" ]; then
      sleep 5
      _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
      rm -f $lehome/${TestingDomain}*/$TestingDomain.key
      rm -f $lehome/${TestingDomain}*/$TestingDomain.csr
    fi
    ) || return
  else
    (
    _info "Testing normal domain. "
    _info "TestingDomain" "$TestingDomain"
    
    lehome="$DEFAULT_HOME"
    rm -rf "$lehome/$TestingDomain"

    if [ -z "$TEST_DNS_NO_SUBDOMAIN" ]; then
      _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" -d \"www.$TestingDomain\" --dns $api --dnssleep \"$d_sleep\" " ||  return
    else
      _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" --dns $api --dnssleep \"$d_sleep\" " ||  return
    fi
    #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
    #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
    _assertcmd "$lehome/$PROJECT_ENTRY --deactivate -d \"$TestingDomain\" >/dev/null 2>&1"
    
    if [ -z "$NO_REVOKE" ]; then
      sleep 5
      _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
    fi
    ) || return 
  fi

  #add a txt record to a subdomain not "_acme-challenge"
  (
    #clear the env and try to use the api again
    if [ "$TokenName1" ]; then
      unset $TokenName1
    fi
    if [ "$TokenName2" ]; then
      unset $TokenName2
    fi
    if [ "$TokenName3" ]; then
      unset $TokenName3
    fi
    if [ "$TokenName4" ]; then
      unset $TokenName4
    fi
    if [ "$TokenName5" ]; then
      unset $TokenName5
    fi

     . $lehome/$PROJECT_ENTRY >/dev/null
     . $lehome/$_SUB_FOLDER_DNSAPI/${api}.sh
     _initpath $TestingDomain
     addcommand="${api}_add"
     rmcommand="${api}_rm"
     random_string="$(date -u "+%s")"
     record_content="acmeTestTxtRecord_acmeTestTxtRecord_acmeTestTxtRecord_$random_string"
     _assertcmd "$addcommand acmetestXyzRandomName.$TestingDomain $record_content"  ||  return
     _assertcmd "$rmcommand  acmetestXyzRandomName.$TestingDomain $record_content"  ||  return
  ) || return

}


#
le_test_standandalone_ipcert() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  if [ -z "$TEST_IPCERT" ] ; then
    _info "Skipped by TEST_IPCERT"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"

  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone" ||  return
  #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi


}

le_test_alpn_ipcert() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  if [ -z "$TEST_IPCERT" ] ; then
    _info "Skipped by TEST_IPCERT"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"

  
  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --alpn" ||  return
  #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" || return

  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi

}



le_test_preferred_chain() {
  if [ -z "$TEST_PREFERRED_CHAIN" ] ; then
    _info "Skipped by TEST_PREFERRED_CHAIN"
    __CASE_SKIPPED="1"
    return 0
  fi
  lehome="$DEFAULT_HOME"


  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and TestingAltDomains, and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain"
  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d \"$TestingDomain\" -d \"$TestingAltDomains\" --standalone --preferred-chain \"$TEST_PREFERRED_CHAIN\" " ||  return
  #_assertcert "$lehome/$TestingDomain/$TestingDomain.cer" "$TestingDomain" "$CA" || return
  #_assertcert "$lehome/$TestingDomain/ca.cer" "$CA" "$TEST_PREFERRED_CHAIN" || return
  
  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain" ||  return
  fi


}



le_test_standandalone_ECDSA_256_pkcs12() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi
  
  if [ "$NO_ECC_CASES" ] ; then
    _info "Skipped by NO_ECC_CASES"
    __CASE_SKIPPED="1"
    return 0
  fi
    
  lehome="$DEFAULT_HOME"

  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"
 
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone -k ec-256" ||  return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.cer" "$TestingDomain" "$CA_ECDSA" || return
  _assertcert "$lehome/$TestingDomain$ECC_SUFFIX/ca.cer" "$CA_ECDSA" || return
  
  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --to-pkcs12 -d $TestingDomain --password test  --ecc" ||  return
  
  _assertcmd "test -f $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pfx"
  rm "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pfx"
  _assertcmd "test ! -f $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pfx"

  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc" ||  return
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key"
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.csr"
  fi

  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force --ecc" ||  return
  _assertcmd "test -f $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pfx"
}


le_test_standandalone_ECDSA_256_pkcs8() {
  if [ "$QUICK_TEST" ] ; then
    _info "Skipped by QUICK_TEST"
    __CASE_SKIPPED="1"
    return 0
  fi

  if [ "$NO_ECC_CASES" ] ; then
    _info "Skipped by NO_ECC_CASES"
    __CASE_SKIPPED="1"
    return 0
  fi

  if ! grep "Le_PKCS8Password" "acme.sh/$PROJECT_ENTRY" >/dev/null 2>&1 ; then
    _info "Skipped, no pkcs8 password support in this branch"
    __CASE_SKIPPED="1"
    return 0
  fi

  lehome="$DEFAULT_HOME"

  if [ -z "$TestingDomain" ] ; then
    __fail "Please define TestingDomain and try again."
    return 1
  fi

  rm -rf "$lehome/$TestingDomain$ECC_SUFFIX"

  _assertcmd "$lehome/$PROJECT_ENTRY  --server \"$TEST_ACME_Server\"  --issue -d $TestingDomain --standalone -k ec-256" ||  return

  _assertcmd "$lehome/$PROJECT_ENTRY  --to-pkcs8 -d $TestingDomain --password test8  --ecc" ||  return
  _assertcmd "test -f $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8"
  #the exported key must be encrypted with the given password
  _assertcmd "openssl pkey -in $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8 -passin pass:test8 -noout" || return
  #wrap the negation in a subshell: _assertcmd runs the command via eval "... &" and
  #bash drops a leading ! from a background job, so wait would see the raw status
  _assertcmd "( ! openssl pkey -in $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8 -passin pass:wrong -noout )" || return

  #the renewal must re-export the pkcs8 file with the saved password
  rm "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8"
  sleep 5
  _assertcmd "$lehome/$PROJECT_ENTRY --renew --server \"$TEST_ACME_Server\" -d $TestingDomain --force --ecc" ||  return
  _assertcmd "test -f $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8"
  _assertcmd "openssl pkey -in $lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.pkcs8 -passin pass:test8 -noout" || return

  if [ -z "$NO_REVOKE" ]; then
    sleep 5
    _assertcmd "$lehome/$PROJECT_ENTRY --revoke -d $TestingDomain --ecc" ||  return
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.key"
    rm -f "$lehome/$TestingDomain$ECC_SUFFIX/$TestingDomain.csr"
  fi
}




le_test_shell() {

  _assertText "1648800633" "$($lehome/$PROJECT_ENTRY _date2time "2022-04-01T08:10:33Z")"  ||  return
  _assertText "1648800633" "$($lehome/$PROJECT_ENTRY _date2time "2022-04-01 08:10:33")"   ||  return
  # A quote in the input must never execute code in the python fallback.
  # Some date(1) implementations leniently parse the leading date and ignore
  # the trailing garbage, so assert only that no injected command ran (the
  # output must not contain the marker), which holds on every platform.
  _inj_out="$($lehome/$PROJECT_ENTRY _date2time '2022-04-01T08:10:33Z"); import os; os.system("echo INJECTED")#' 2>/dev/null)"
  _inj_verdict=clean
  case "$_inj_out" in
  *INJECTED*) _inj_verdict=dirty ;;
  esac
  _assertText "clean" "$_inj_verdict"  ||  return
  _assertText "2022-04-01T08:10:33Z" "$($lehome/$PROJECT_ENTRY _time2str "1648800633")"   ||  return
  _assertText "ABC" "$(echo abc | tr [a-z] [A-Z])"   ||  return
  _assertText "ABC" "$(echo abc | tr '[a-z]' '[A-Z]')"   ||  return
  _assertText "ABC" "$(echo "abc" | $lehome/$PROJECT_ENTRY _upper_case)"  ||  return
  _assertText "abc" "$(echo "ABC" | $lehome/$PROJECT_ENTRY _lower_case)"  ||  return

  # issue #968: on shells without egrep, _egrep_o falls back to a BRE sed
  # expression where a bare "\{" is an interval operator and aborts (GNU sed
  # "Invalid content of \{\}", Solaris sed "command garbled"), so the
  # challenge-status-invalid path extracts an empty error object and the CA's
  # failure reason is lost. A "[{]" bracket expression is an unambiguous
  # literal brace in both BRE (sed fallback) and ERE (egrep), unlike a bare
  # "{" (an interval operator in ERE) or an escaped "\{" (an interval in BRE).
  _errjson968='{"type":"dns-01","status":"invalid","error":{"type":"urn:ietf:params:acme:error:unauthorized","detail":"Incorrect TXT record","status":403},"url":"https://acme/chall/1"}'
  _errobj968="$(echo "$_errjson968" | $lehome/$PROJECT_ENTRY _egrep_o '"error":[{][^}]*')"
  _errdetail968="$(echo "$_errobj968" | $lehome/$PROJECT_ENTRY _egrep_o '"detail": *"[^"]*' | cut -d '"' -f 4)"
  _assertText "Incorrect TXT record" "$_errdetail968"  ||  return
}

le_test_assertcmd_timeout() {

  #_assertcmd must kill a command that exceeds LE_CMD_TIMEOUT, fail, and
  #dump cmd.log instead of hanging until the CI job limit (issue #4145).
  _act_out="$(LE_CMD_TIMEOUT=5; _assertcmd "sleep 60" 2>&1)"
  _act_ret="$?"
  _act_verdict=ok
  if [ "$_act_ret" = "0" ]; then
    _act_verdict=no_error
  fi
  case "$_act_out" in
  *"timed out after 5 seconds"*) ;;
  *) _act_verdict=no_timeout_message ;;
  esac
  _assertText "ok" "$_act_verdict" || return

  #a fast successful command must still pass under the timeout logic
  _assertcmd "echo assertcmd fast path" || return
}

le_test_cleardeployconf() {

  #_cleardeployconf must remove both the SAVED_ prefixed key and the
  #legacy unprefixed key from the domain conf, and keep other keys.
  _cdc_file="$(mktemp)"
  {
    echo "SAVED_DEPLOY_TEST_USER='u1'"
    echo "DEPLOY_TEST_USER='u0'"
    echo "SAVED_DEPLOY_KEEP='k1'"
  } >"$_cdc_file"
  DOMAIN_CONF="$_cdc_file" "$lehome/$PROJECT_ENTRY" _cleardeployconf DEPLOY_TEST_USER >/dev/null 2>&1
  _cdc_out="$(cat "$_cdc_file")"
  rm "$_cdc_file"
  _cdc_cleared=ok
  case "$_cdc_out" in
  *DEPLOY_TEST_USER*) _cdc_cleared=leftover ;;
  esac
  _assertText "ok" "$_cdc_cleared"  ||  return
  _cdc_kept=missing
  case "$_cdc_out" in
  *"SAVED_DEPLOY_KEEP='k1'"*) _cdc_kept=ok ;;
  esac
  _assertText "ok" "$_cdc_kept"  ||  return
}

le_test_mailto_contacts() {
  lehome="$DEFAULT_HOME"

  _assertText '"mailto:a@example.com"' "$(echo "a@example.com" | $lehome/$PROJECT_ENTRY _mailto_contacts)" || return
  _assertText '"mailto:a@example.com","mailto:b@example.net"' "$(echo "a@example.com b@example.net" | $lehome/$PROJECT_ENTRY _mailto_contacts)" || return
  _assertText '"mailto:a@example.com","mailto:b@example.net"' "$(echo "a@example.com,b@example.net" | $lehome/$PROJECT_ENTRY _mailto_contacts)" || return
  _assertText '"mailto:a@example.com","mailto:b@example.net"' "$(echo "a@example.com, b@example.net" | $lehome/$PROJECT_ENTRY _mailto_contacts)" || return
  #empty input must produce empty output so callers can guard on emptiness
  _assertText "" "$(echo "" | $lehome/$PROJECT_ENTRY _mailto_contacts)" || return
}

le_test_isIPv4() {

  #_isIPv4 must accept only well-formed dotted quads, and a "*" segment
  #must not glob against files in the current directory (issue 4971);
  #the test dir contains a file named "1" to catch exactly that.
  _ipv4_dir="$(mktemp -d)"
  touch "$_ipv4_dir/1"
  _ipv4_got=""
  for _ipv4_case in '1.2.3.4' '255.255.255.255' '0.0.0.0' '*.*.*.*' '1.2.3' '1.2.3.4.5' '256.1.1.1' 'a.b.c.d' '1..2.3' '12' ''; do
    if (cd "$_ipv4_dir" && "$lehome/$PROJECT_ENTRY" _isIPv4 "$_ipv4_case") >/dev/null 2>&1; then
      _ipv4_got="${_ipv4_got}Y"
    else
      _ipv4_got="${_ipv4_got}N"
    fi
  done
  rm "$_ipv4_dir/1"
  # _isIPv4 runs acme.sh with the temp dir as cwd, so acme.sh appends its run
  # log to the relative $LOG_FILE ("le_test_isIPv4.log") inside that dir;
  # remove it too, otherwise rmdir fails with "Directory not empty".
  [ -f "$_ipv4_dir/$LOG_FILE" ] && rm "$_ipv4_dir/$LOG_FILE"
  rmdir "$_ipv4_dir"
  _assertText "YYYNNNNNNNN" "$_ipv4_got"  ||  return
}

le_test_is_valid_cn() {

  #_is_valid_cn gates the CN slot of the CSR subject: at most 64 chars
  #(RFC 5280 ub-common-name), never an IP address, never empty, so that
  #_createcsr omits the CN instead of failing inside openssl on long
  #FQDNs (issue 4867). Cases: normal, 63, 64, 65 chars, IPv4, IPv6, empty.
  _cn_got=""
  for _cn_case in 'example.com' 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.example.org' 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.example.org' 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.example.org' '1.2.3.4' '2001:db8::1' ''; do
    if "$lehome/$PROJECT_ENTRY" _is_valid_cn "$_cn_case" >/dev/null 2>&1; then
      _cn_got="${_cn_got}Y"
    else
      _cn_got="${_cn_got}N"
    fi
  done
  _assertText "YYYNNNN" "$_cn_got"  ||  return
}

le_test_parse_authorizations() {

  #IPv6 server URLs: brackets inside the URLs must not truncate the array
  _j6='{"id":"x","status":"pending","identifiers":[{"type":"dns","value":"a.example.com"},{"type":"dns","value":"b.example.com"}],"authorizations":["https://[2001:db8::1]/acme/authz/AAA","https://[2001:db8::1]/acme/authz/BBB"],"finalize":"https://[2001:db8::1]/acme/order/x/finalize"}'
  _assertText "https://[2001:db8::1]/acme/authz/AAA,https://[2001:db8::1]/acme/authz/BBB" "$(echo "$_j6" | $lehome/$PROJECT_ENTRY _authorizations_from_order)"  ||  return

  #hostname, single entry
  _jh='{"status":"pending","authorizations":["https://acme-v02.api.letsencrypt.org/acme/authz/CCC"],"finalize":"https://acme-v02.api.letsencrypt.org/acme/finalize/1/2"}'
  _assertText "https://acme-v02.api.letsencrypt.org/acme/authz/CCC" "$(echo "$_jh" | $lehome/$PROJECT_ENTRY _authorizations_from_order)"  ||  return

  #IPv4 with spaces around the array elements
  _j4='{"status":"pending","authorizations": [ "https://10.0.0.1/acme/authz/DDD" , "https://10.0.0.1/acme/authz/EEE" ],"finalize":"https://10.0.0.1/f"}'
  _assertText "https://10.0.0.1/acme/authz/DDD,https://10.0.0.1/acme/authz/EEE" "$(echo "$_j4" | $lehome/$PROJECT_ENTRY _authorizations_from_order)"  ||  return

  #escaped slashes are handled by _json_decode before parsing
  _je='{"authorizations":["https:\/\/[2001:db8::1]\/acme\/authz\/FFF"]}'
  _assertText "https://[2001:db8::1]/acme/authz/FFF" "$(echo "$_je" | $lehome/$PROJECT_ENTRY _json_decode | $lehome/$PROJECT_ENTRY _authorizations_from_order)"  ||  return

  #error response without an authorizations field must produce empty output
  _jerr='{"type":"urn:ietf:params:acme:error:malformed","detail":"some [bad] thing","status":400}'
  _assertText "" "$(echo "$_jerr" | $lehome/$PROJECT_ENTRY _authorizations_from_order)"  ||  return
}

#CN, SAN list -> generate a CSR and print the parsed alt names
#same key/subj/config pattern as _createcsr: NetBSD openssl has no default
#/etc/openssl/openssl.cnf and aborts on -newkey with a dn section
__gen_csr_and_read_altnames() {
  __csr_cn="$1"
  __csr_san="$2"
  __csr_tmp="/tmp/le_test_csr.$$"
  mkdir -p "$__csr_tmp"
  printf "[ req_distinguished_name ]\n[ req ]\ndistinguished_name = req_distinguished_name\nreq_extensions = v3_req\n[ v3_req ]\nsubjectAltName=%s\n" "$__csr_san" >"$__csr_tmp/req.conf"
  openssl genrsa 2048 >"$__csr_tmp/t.key" 2>/dev/null
  openssl req -new -sha256 -key "$__csr_tmp/t.key" -subj "/CN=$__csr_cn" -config "$__csr_tmp/req.conf" -out "$__csr_tmp/t.csr" >/dev/null 2>&1
  $lehome/$PROJECT_ENTRY _readSubjectAltNamesFromCSR "$__csr_tmp/t.csr"
}


le_test_read_altnames_from_csr() {

  #wildcard subject present in SAN must be removed, not duplicated (issue 5251:
  #the '*' was taken as a regex operator so the match never succeeded)
  _assertText "www.example.com" "$(__gen_csr_and_read_altnames "*.example.com" "DNS:*.example.com,DNS:www.example.com")"  ||  return

  #plain subject present in SAN is removed
  _assertText "www.example.com" "$(__gen_csr_and_read_altnames "example.com" "DNS:example.com,DNS:www.example.com")"  ||  return

  #subject not in SAN: list must be unchanged
  _assertText "www.example.com" "$(__gen_csr_and_read_altnames "example.com" "DNS:www.example.com")"  ||  return
}


le_test_send_notify_clears_headers() {

  #the dns/deploy hooks export _H1.._H5 in the main process and notify
  #hooks run in a subshell that inherits them, so _send_notify must clear
  #the slots: a stale Authorization header from another service must not
  #leak into the notify request
  _nh_out="/tmp/le_test_notify_h.$$"
  mkdir -p "$lehome/notify"
  printf 'le_hooktest_send() {\n  printf "H1=%%s|H2=%%s|H3=%%s|H4=%%s|H5=%%s" "$_H1" "$_H2" "$_H3" "$_H4" "$_H5" >"$LE_TEST_NOTIFY_OUT"\n  return 0\n}\n' >"$lehome/notify/le_hooktest.sh"
  LE_WORKING_DIR="$lehome" LE_TEST_NOTIFY_OUT="$_nh_out" \
    _H1="Authorization: Bearer leaked-token" _H2="X-Stale: 2" _H3="X-Stale: 3" _H4="X-Stale: 4" _H5="X-Stale: 5" \
    "$lehome/$PROJECT_ENTRY" _send_notify "subject" "content" "le_hooktest" 0 >/dev/null 2>&1
  _assertText "H1=|H2=|H3=|H4=|H5=" "$(cat "$_nh_out" 2>/dev/null)"  ||  return
}


#--update-account -m must persist the new mailbox locally: the CA-side
#contact was updated but the ca conf kept the old CA_EMAIL (issue 4673)
le_test_update_account_email() {
  lehome="$DEFAULT_HOME"

  _assertcmd "$lehome/$PROJECT_ENTRY --register-account --server \"$TEST_ACME_Server\"" || return
  _uae_mail="letest-uae@acme.sh"
  _assertcmd "$lehome/$PROJECT_ENTRY --update-account -m \"$_uae_mail\" --server \"$TEST_ACME_Server\"" || return
  #find+grep instead of grep -r: Solaris grep has no -r
  if [ -z "$(find "$lehome/ca" -name "ca.conf" -exec grep "CA_EMAIL='$_uae_mail'" {} \; 2>/dev/null)" ]; then
    __fail "The new email was not saved as CA_EMAIL in the ca conf"
    return 1
  fi

  #-m accepts multiple mailboxes (comma or space separated); the whole
  #list must be persisted verbatim
  _uae_mail2="letest-uae1@acme.sh,letest-uae2@acme.sh"
  _assertcmd "$lehome/$PROJECT_ENTRY --update-account -m \"$_uae_mail2\" --server \"$TEST_ACME_Server\"" || return
  if [ -z "$(find "$lehome/ca" -name "ca.conf" -exec grep "CA_EMAIL='$_uae_mail2'" {} \; 2>/dev/null)" ]; then
    __fail "The multi-email list was not saved as CA_EMAIL in the ca conf"
    return 1
  fi
}


le_test_calc_next_renew_time() {

  #the default RenewalDays schedule must never pass the cert expiry
  #(issue 6305): capped at 1 day before endtime, or 1 hour before for
  #certs whose lifetime is 24 hours or less
  _nrt_create=1000000000
  #90-day cert, 60-day schedule: no clamping
  _assertText "1005097600" "$("$lehome/$PROJECT_ENTRY" _calc_next_renew_time "$_nrt_create" 60 "$(_math "$_nrt_create" + 7776000)")"  ||  return
  #7-day cert, 60-day schedule: clamped to endtime - 1 day
  _assertText "1000518400" "$("$lehome/$PROJECT_ENTRY" _calc_next_renew_time "$_nrt_create" 60 "$(_math "$_nrt_create" + 604800)")"  ||  return
  #6-hour cert: clamped to endtime - 1 hour
  _assertText "1000018000" "$("$lehome/$PROJECT_ENTRY" _calc_next_renew_time "$_nrt_create" 60 "$(_math "$_nrt_create" + 21600)")"  ||  return
  #no endtime available: previous fixed-schedule behavior
  _assertText "1005097600" "$("$lehome/$PROJECT_ENTRY" _calc_next_renew_time "$_nrt_create" 60 "")"  ||  return
}


le_test_calc_validto_renew_time() {

  #relative --valid-to scheduling: a negative --days is anchored to the
  #expiry; otherwise renew 1 day before the expiry, or 1 hour before for
  #certs whose lifetime is 24 hours or less
  _cvt_end=1000000000
  #negative days: end - 7 days
  _assertText "999395200" "$("$lehome/$PROJECT_ENTRY" _calc_validto_renew_time "$_cvt_end" -7 "$(_math "$_cvt_end" - 2592000)")"  ||  return
  #positive days (default schedule), 30-day lifetime: end - 1 day
  _assertText "999913600" "$("$lehome/$PROJECT_ENTRY" _calc_validto_renew_time "$_cvt_end" 60 "$(_math "$_cvt_end" - 2592000)")"  ||  return
  #6-hour lifetime: end - 1 hour
  _assertText "999996400" "$("$lehome/$PROJECT_ENTRY" _calc_validto_renew_time "$_cvt_end" 60 "$(_math "$_cvt_end" - 21600)")"  ||  return
  #empty days: end - 1 day
  _assertText "999913600" "$("$lehome/$PROJECT_ENTRY" _calc_validto_renew_time "$_cvt_end" "" "$(_math "$_cvt_end" - 2592000)")"  ||  return

  #the --days/--valid-to gate in _process
  lehome="$DEFAULT_HOME"
  #positive --days with --valid-to: rejected
  if "$lehome/$PROJECT_ENTRY" --list --days 10 --valid-to "+30d" >/dev/null 2>&1; then
    __fail "positive --days with --valid-to must be rejected"
    return 1
  fi
  #any --days with a fixed-date --valid-to: rejected
  if "$lehome/$PROJECT_ENTRY" --list --days -7 --valid-to "2039-01-01T00:00:00Z" >/dev/null 2>&1; then
    __fail "--days with fixed-date --valid-to must be rejected"
    return 1
  fi
  #negative --days with a relative --valid-to: accepted
  _assertcmd "$lehome/$PROJECT_ENTRY --list --days -7 --valid-to \"+30d\""  ||  return
}


le_test_strip_blank_lines() {
  lehome="$DEFAULT_HOME"

  #the certs of a chain must be stored back to back: some CAs (Let's Encrypt)
  #separate them with a blank line, others (ZeroSSL) don't (issue 1940)
  _sbl_chain="-----BEGIN CERTIFICATE-----
leaf
-----END CERTIFICATE-----

-----BEGIN CERTIFICATE-----
intermediate
-----END CERTIFICATE-----
"
  _sbl_expected="-----BEGIN CERTIFICATE-----
leaf
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
intermediate
-----END CERTIFICATE-----"
  _assertText "$_sbl_expected" "$(printf "%s" "$_sbl_chain" | "$lehome/$PROJECT_ENTRY" _strip_blank_lines)"  ||  return

  #a chain without blank lines is passed through unchanged
  _assertText "$_sbl_expected" "$(printf "%s" "$_sbl_expected" | "$lehome/$PROJECT_ENTRY" _strip_blank_lines)"  ||  return

  #whitespace-only separator lines are removed too
  _sbl_ws=$(printf -- '-----BEGIN CERTIFICATE-----\nleaf\n-----END CERTIFICATE-----\n \t\n-----BEGIN CERTIFICATE-----\nintermediate\n-----END CERTIFICATE-----\n')
  _assertText "$_sbl_expected" "$(printf "%s" "$_sbl_ws" | "$lehome/$PROJECT_ENTRY" _strip_blank_lines)"  ||  return

  #the base64 body of a real cert is not touched
  _assertText "3" "$(printf -- '-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A\n-----END CERTIFICATE-----\n' | "$lehome/$PROJECT_ENTRY" _strip_blank_lines | wc -l | tr -d ' ')"  ||  return

  #empty input stays empty
  _assertText "" "$(printf "" | "$lehome/$PROJECT_ENTRY" _strip_blank_lines)"  ||  return
}


le_test_installcronjob_no_wipe() {
  lehome="$DEFAULT_HOME"

  #installcronjob pipes 'crontab -l' back into 'crontab -'; if the listing
  #fails while the user has jobs, that would replace the whole crontab with
  #just the acme.sh entry (issue 3079). The fake crontab below simulates the
  #three listing outcomes and records what gets written.
  _icj_dir="$lehome/icj_fakebin"
  mkdir -p "$_icj_dir"
  cat >"$_icj_dir/crontab" <<'ICJEOF'
#!/bin/sh
_dir="$(dirname "$0")"
_mode="$(cat "$_dir/mode")"
if [ "$1" = "-l" ]; then
  case "$_mode" in
  fail)
    echo "crontab: temporary failure" >&2
    exit 1
    ;;
  none)
    echo "no crontab for tester" >&2
    exit 1
    ;;
  jobs)
    echo "1 2 * * * /bin/existing-job"
    ;;
  esac
  exit 0
fi
cat >"$_dir/crontab.state"
ICJEOF
  chmod +x "$_icj_dir/crontab"

  #listing fails: must refuse and must not touch the crontab
  echo "fail" >"$_icj_dir/mode"
  if PATH="$_icj_dir:$PATH" "$lehome/$PROJECT_ENTRY" --install-cronjob >/dev/null 2>&1; then
    __fail "install-cronjob must fail when the cron jobs can not be listed"
    return 1
  fi
  if [ -f "$_icj_dir/crontab.state" ]; then
    __fail "the crontab was modified although the job list could not be read"
    return 1
  fi

  #no crontab yet: a fresh install must still work
  echo "none" >"$_icj_dir/mode"
  _assertcmd "PATH=\"$_icj_dir:\$PATH\" \"$lehome/$PROJECT_ENTRY\" --install-cronjob" || return
  if ! grep "$PROJECT_ENTRY --cron" "$_icj_dir/crontab.state" >/dev/null 2>&1; then
    __fail "the cron entry was not installed into an empty crontab"
    return 1
  fi

  #existing jobs must ride along unchanged
  echo "jobs" >"$_icj_dir/mode"
  _assertcmd "PATH=\"$_icj_dir:\$PATH\" \"$lehome/$PROJECT_ENTRY\" --install-cronjob" || return
  if ! grep "/bin/existing-job" "$_icj_dir/crontab.state" >/dev/null 2>&1; then
    __fail "the existing cron job was dropped from the crontab"
    return 1
  fi
  if ! grep "$PROJECT_ENTRY --cron" "$_icj_dir/crontab.state" >/dev/null 2>&1; then
    __fail "the cron entry was not appended next to the existing jobs"
    return 1
  fi
}


#expected,  actual
_assertText() {
  if [ "$1" != "$2" ]; then
    __fail "Expected: $1 , but was: $2"
    return 1
  fi
  return 0
}


#####################################

if [ "$1" ] ; then
  CASE="$1"
fi

_date_u

_setup

_ret=0

total=$(grep ^le_test_  $FILE_NAME | wc -l | tr -d ' ')
num=1
for t in $(grep ^le_test_  $FILE_NAME | cut -d '(' -f 1) 
do
  if [ -z "$CASE" ] ; then
    __green "Progress: "
    __green "$num/"
    [ "$_ret" = "0" ] && __green "$_ret" || __red "$_ret"
    __green "/$total"

    printf "\n"
    num=$(_math $num + 1)
  fi
  _rr=0
  _debug t "$t"
  _case_log="$t.log"
  if [ -z "$CASE" ] || _hasfield "$CASE" "$t"; then
    _saved_log="$LOG_FILE"
    export LOG_FILE="$_case_log"
    _run "$t"
    _rr="$?"
    export LOG_FILE="$_saved_log"
    cat "$_case_log" >> "$LOG_FILE"
    _debug "_rr" "$_rr"
    _ret=$(_math $_ret + $_rr)
    _debug _ret "$_ret"
  fi
  if [ -e "$_case_log" ]; then
    chmod o+r "$_case_log"
  fi

  if [ "$_ret" != "0" ] ; then
    if [ "$TRAVIS" = "true" ] || [ "$CI" = "true" ] ; then
      cat "$_case_log"
      break
    fi
    if [ "$DEBUG" ] || [ "$DEBUGING" ] ; then 
      break;
    fi
  fi
  if [ "$CASE" = "$t" ] ; then
    break;
  fi
done

if [ "$CF_PID" ] ; then
  kill -9 "$CF_PID"
  if [ "$_ret" != "0" ]; then
    cat "$ng_temp_1"
  fi
fi

if [ "$NGROK_PID" ] ; then
  kill -9 "$NGROK_PID"
fi

if [ -e "$LOG_FILE" ]; then
  chmod o+r "$LOG_FILE"
fi

exit $_ret




