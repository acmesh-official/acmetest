
Img="https://cdn.rawgit.com/Neilpang/acmetest/master/status"

LogLink="https://github.com/Neilpang/acmetest/blob/master"

Conf="plat.conf"

Table="table.md"

DEFAULT_SCRIPT="letest.sh"

if [ -z "$TestingDomain" ] ; then
  TestingDomain=testdocker.acme.sh
fi

if [ -z "$TestingAltDomains" ] ; then
  TestingAltDomains=testdocker2.acme.sh
fi

if [ -z "$RUN_SCRIPT" ] ; then
  RUN_SCRIPT="$DEFAULT_SCRIPT"
fi


_date_u() {
  date -u +"%a, %d %b %Y %T %Z"
}

_info() {
  if [ -z "$2" ] ; then
    echo "[$(date)] $1"
  else
    echo "[$(date)] $1"="'$2'"
  fi
}

_err() {
  _info "$@" >&2
  return 1
}

_debug() {
  if [ -z "$DEBUG" ] ; then
    return
  fi
  _err "$@"
  return 0
}

_debug2() {
  if [ "$DEBUG" ] && [ "$DEBUG" -ge "2" ] ; then
    _debug "$@"
  fi
  return
}

_debug3() {
  if [ "$DEBUG" ] && [ "$DEBUG" -ge "3" ] ; then
    _debug "$@"
  fi
  return
}

#plat
_normalizeFilename() {
  _nplat="$1"
  printf "%s" "$_nplat" | tr ':/ \\' '----' 
}

#plat
_getOutfile() {
  _gnplat="$1"
  statusfile="$(_normalizeFilename "$_gnplat")"
  printf "%s" "logs/$statusfile.out"
}

#plat
_getLogfile() {
  _lnplat="$1"
  statusfile="$(_normalizeFilename "$_lnplat")"
  printf "%s" "logs/$statusfile.log"
}

_time() {
  date -u "+%s"
}

#update plat code [file]
update() {
  plat="$1"
  code="$2"
  filename="$3"
  if [ -z "$filename" ] ; then
    filename="$Table"
  fi
  
  if [ -z "$code" ] ; then
    _err "Usage: plat exitcode [filename:table.md]"
    return 1
  fi
  
  statusfile="$(_normalizeFilename "$plat")"

  if [ "$code" = "0" ] ; then
    __ok "$plat"
  else
    __fail "$plat"
  fi
  
  if [ "$CI" = "1" ] ; then
    if ! git pull >/dev/null 2>&1 ; then 
      _err "git pull error"
    fi
    _status="Passed"
    if [ "$code" = "0" ] ; then
      if [ -f "status/ok.svg" ] ; then
        cat "status/ok.svg" > "status/$statusfile.svg"
      fi
      _status="Passed"
    else
      if [ -f "status/ng.svg" ] ; then
        cat "status/ng.svg" > "status/$statusfile.svg"
      fi
      _status="Failed"
    fi
    
    git add "status/$statusfile.svg" >/dev/null 2>&1
    
    outfile="$(_getOutfile "$plat")"
    
    _setopt "$filename" "|$plat| " '!' "[]($Img/$statusfile.svg?$(_time))| $(_date_u)| [$_status]($LogLink/$outfile) |"
    
    #_sed_i  's/\x1b\[1;31;32m//g' "$outfile" >/dev/null 2>&1
    #_sed_i  's/\[1;31;32m//g' "$outfile" >/dev/null 2>&1
    #
    #_sed_i  's/\x1b\[0m//g' "$outfile" >/dev/null 2>&1
    #_sed_i  's/\[0m//g' "$outfile" >/dev/null 2>&1
    
    git add "$outfile" >/dev/null 2>&1
    
    git add "$filename" >/dev/null 2>&1
    cat head.md "$Table" tail.md > README.md
    git add *.md >/dev/null 2>&1
    git commit -m "Test for $plat" >/dev/null 2>&1
    if ! git push >/dev/null 2>&1 ; then 
      _err "git push error"
    fi
  fi
}

_contains(){
  _str="$1"
  _sub="$2"
  echo $_str | grep $_sub >/dev/null 2>&1
}

#options file
_sed_i() {
  options="$1"
  filename="$2"
  if [ -z "$filename" ] ; then
    _err "Usage:_sed_i options filename"
    return 1
  fi
  _debug2 options "$options"
  if sed -h 2>&1 | grep "\-i\[SUFFIX]" >/dev/null 2>&1; then
    _debug "Using sed  -i"
    sed -i "$options" "$filename"
  else
    _debug "No -i support in sed"
    text="$(cat "$filename")"
    echo "$text" | sed "$options" > "$filename"
  fi
}

#setopt "file"  "opt"  "="  "value" [";"]
_setopt() {
  __conf="$1"
  __opt="$2"
  __sep="$3"
  __val="$4"
  __end="$5"
  if [ -z "$__opt" ] ; then 
    echo usage: _setopt  '"file"  "opt"  "="  "value" [";"]'
    return
  fi
  if [ ! -f "$__conf" ] ; then
    touch "$__conf"
  fi

  if grep -n "^$__opt$__sep" "$__conf" > /dev/null ; then
    _debug3 OK
    if _contains "$__val" "&" ; then
      __val="$(echo $__val | sed 's/&/\\&/g')"
    fi

    text="$(cat $__conf)"
    echo "$text" | sed "s#^$__opt.*#$__opt$__sep$__val$__end#" > "$__conf"

  else
    _debug3 APP
    echo "$__opt$__sep$__val$__end" >> "$__conf"
  fi

}

#__INTERACTIVE=""
#if [ -t 1 ]; then
  __INTERACTIVE="1"
#fi

__green() {
  if [ "$__INTERACTIVE${ACME_NO_COLOR}" = "1" ]; then
    printf '\033[1;31;32m'
  fi
  printf "$1"
  if [ "$__INTERACTIVE${ACME_NO_COLOR}" = "1" ]; then
    printf '\033[0m'
  fi
}

__ok() {
  __green "$1 [PASS]"
  printf "\n"
}

__red() {
  if [ "$__INTERACTIVE${ACME_NO_COLOR}" = "1" ]; then
    printf '\033[1;31;40m'
  fi
  printf "$1"
  if [ "$__INTERACTIVE${ACME_NO_COLOR}" = "1" ]; then
    printf '\033[0m'
  fi
}

__fail() {
  __red "$1 [FAIL]" >&2
  printf "\n" >&2
  return 1
}


#platline baseline fieldnum
_mergefield() {
  platline="$1"
  baseline="$2"
  fieldnum="$3"
  
  pvalue="$(echo "$platline" | cut -d '|' -f $fieldnum)"
  if [ ! "$pvalue" ] ; then
    pvalue="$(echo "$baseline" | cut -d '|' -f $fieldnum)"
  fi

  echo "$pvalue"  
}

#plat
#ubuntu:14.04
#centos:6
_runplat() {
  plat="$1"
  if [ ! "$plat" ] ; then
    _err "Usage: _runplat ubuntu:14.04"
    return 1
  fi
  
  platname="$(echo $plat | tr "/" "-")"
  
  myplat="my$platname"
  
  platline="$(grep "^$plat[^ |]*" "$Conf" | tr -d "\r\n")"
  _debug "platline" "$platline"
  
  basetag=""
  baseline=""
  if _contains "$plat" ":" ; then
    basetag="$(echo "$plat" | cut -d : -f 1)"
    _debug "basetag" "$basetag"
    baseline="$(grep "^-$basetag[^ |]*" "$Conf" | tr -d "\r\n" )"
  fi
  _debug "baseline" "$baseline"

  _info "Running $( __green $plat), this may take a few minutes, please wait."
  mkdir -p "$myplat"

  echo "FROM $plat" > "$myplat/Dockerfile"
  
  update="$(_mergefield "$platline" "$baseline" 2)"
  _debug "update" "$update"
  
  buildq="2>&1"
  if [ "$DEBUG" ] || [ "$DEBUGING" ] ; then
    buildq=""
  fi
 
  install="$(_mergefield "$platline" "$baseline" 3)"
  _debug "install" "$install"
  
  if [ "$install" ] ; then
  
    echo "RUN ${update:+$update $buildq &&} $install \\" >> "$myplat/Dockerfile"

    tools="$(_mergefield "$platline" "$baseline" 4)"
    if [ "$tools" ] ; then
      toolsline=$(echo "$tools" |  tr ',' ' ' )

      if [ "$toolsline" ] ; then
        echo "$toolsline  $buildq"  >>  "$myplat/Dockerfile"
      fi

    fi
  fi

  if [ "$DEBUGING" ] ; then
    cat "$myplat/Dockerfile"
  fi
  

  Log_Out="$(_getOutfile "$plat")"
  _debug "Log_Out" "$Log_Out"
  #docker pull $plat > "$Log_Out" 2>&1
  if docker build -t "$myplat"  "$myplat" > "$Log_Out" 2>&1 ; then

    if [ -z "$LOG_FILE" ] ; then
      LOG_FILE="$(_getLogfile "$plat")"
      echo "" > "$LOG_FILE"
    fi
    _debug "LOG_FILE" "$LOG_FILE"
    
    if [ "$DEBUGING" ] ; then
      docker run --net=host --rm \
      -e TestingDomain=$TestingDomain \
      -e TestingAltDomains=$TestingAltDomains \
      -e DEBUG="$DEBUG" \
      -e LOG_FILE="$LOG_FILE" \
      -e LOG_LEVEL="$LOG_LEVEL" \
      -e BRANCH=$BRANCH \
      -e RUN_IN_DOCKER=1 \
      -e DOCKER_OS="$plat" \
      -e QUICK_TEST="$QUICK_TEST" \
      -e TEST_LOCAL="$TEST_LOCAL" \
      -e TEST_IPV6="$TEST_IPV6" \
      -e TEST_IDN="$TEST_IDN" \
      -e TEST_IDN="$TEST_DNS" \
      -e CASE="$CASE" \
      -e ACME_NO_COLOR="$ACME_NO_COLOR" \
      -e NGROK_TOKEN=$NGROK_TOKEN \
      -v $(pwd):/acmetest \
      $myplat /bin/sh -c "cd /acmetest && ./$RUN_SCRIPT"
    else
      if [ "$TRAVIS" = "true" ] ; then
        export TestingDomain=""
        export TestingAltDomains=""
        docker run --net=host --rm \
        -e TestingDomain=$TestingDomain \
        -e TestingAltDomains=$TestingAltDomains \
        -e DEBUG="$DEBUG" \
        -e LOG_FILE="$LOG_FILE" \
        -e LOG_LEVEL="$LOG_LEVEL" \
        -e BRANCH=$BRANCH \
        -e RUN_IN_DOCKER=1 \
        -e DOCKER_OS="$plat" \
        -e QUICK_TEST="$QUICK_TEST" \
        -e TEST_LOCAL="$TEST_LOCAL" \
        -e TEST_IPV6="$TEST_IPV6" \
        -e TEST_IDN="$TEST_IDN" \
        -e TEST_IDN="$TEST_DNS" \
        -e CASE="$CASE" \
        -e ACME_NO_COLOR="$ACME_NO_COLOR" \
        -e NGROK_TOKEN=$NGROK_TOKEN \
        -e TRAVIS=$TRAVIS \
        -v $(pwd):/acmetest \
        $myplat /bin/sh -c "cd /acmetest && ./$RUN_SCRIPT"
      else 
        docker run --net=host --rm \
        -e TestingDomain=$TestingDomain \
        -e TestingAltDomains=$TestingAltDomains \
        -e DEBUG="$DEBUG" \
        -e LOG_FILE="$LOG_FILE" \
        -e LOG_LEVEL="$LOG_LEVEL" \
        -e BRANCH=$BRANCH \
        -e RUN_IN_DOCKER=1 \
        -e DOCKER_OS="$plat" \
        -e QUICK_TEST="$QUICK_TEST" \
        -e TEST_LOCAL="$TEST_LOCAL" \
        -e TEST_IPV6="$TEST_IPV6" \
        -e TEST_IDN="$TEST_IDN" \
        -e TEST_IDN="$TEST_DNS" \
        -e CASE="$CASE" \
        -e ACME_NO_COLOR="$ACME_NO_COLOR" \
        -e NGROK_TOKEN=$NGROK_TOKEN \
        -v $(pwd):/acmetest \
        $myplat /bin/sh -c "cd /acmetest && ./$RUN_SCRIPT" >> "$Log_Out" 2>&1
      fi
    fi

    code="$?"
    _debug "code" "$code"

    if [ "$code" != "0" ] ; then
      cat "$Log_Out"
      if [ "$DEBUGING" ] ; then
        _info "Please debuging:"
        docker run --net=host --rm \
        -i -t \
        -e TestingDomain=$TestingDomain \
        -e TestingAltDomains=$TestingAltDomains \
        -e DEBUG="$DEBUG" \
        -e LOG_FILE="$LOG_FILE" \
        -e LOG_LEVEL="$LOG_LEVEL" \
        -e BRANCH=$BRANCH \
        -e RUN_IN_DOCKER=1 \
        -e DOCKER_OS="$plat" \
        -e QUICK_TEST="$QUICK_TEST" \
        -e TEST_LOCAL="$TEST_LOCAL" \
        -e TEST_IPV6="$TEST_IPV6" \
        -e TEST_IDN="$TEST_IDN" \
        -e CASE="$CASE" \
        -e ACME_NO_COLOR="$ACME_NO_COLOR" \
        -e NGROK_TOKEN=$NGROK_TOKEN \
        -v $(pwd):/acmetest \
        $myplat /bin/sh
      fi
    fi
  else
    code="$?"
    _debug "code" "$code"
    cat "$Log_Out"
  fi

  update $plat $code
  return $code

}

#plat
testplat() {
  plat="$1"
  
  if [ ! "$plat" ] ; then
    _err "Usage: testplat ubuntu:14.04"
    return 1
  fi
  
  if [ "$CASE" ] ; then
    echo "Test for case: $(__green "$CASE")"
  fi
  
  platforms=$(grep -o "^$plat[^ |]*" "$Conf" )
  if [ ! "$platforms" ] ; then
    platforms="$plat"
  fi
  _debug "$platforms"

  for plat in $platforms 
  do 
    if ! _runplat "$plat" ; then
      _rret="$?"
      if [ -z "$DEBUG" ] && [ -z "$DEBUGING" ] ; then
        _info "Let's retry once more:$plat"
        _runplat "$plat"
        _rret="$?"
      fi
      if [ "$_rret" != "0" ] ; then
        _info "Failed: $plat"
        _FAILED_PLATS="$_FAILED_PLATS$plat "
        if [ "$TRAVIS" = "true" ] ; then
          return "$_rret"
        fi
      fi
    fi
  done
}

#plat1 plat2 plat3
testplats() {
  if [ -z "$@" ] ; then
    _err "Usage: testplats plat1 plat2 plat3 ... "
    return 1
  fi
  for tps in "$@" ; do
    [ "$tps" ] && testplat "$tps"
  done
}


cleardocker() {
  docker rm $(docker ps -a -q)
  #docker rmi $(docker images -q -f "dangling=true")
}


showhelp() {
  _info "testall|testplat|testplats|cleardocker|_cron"
}


testall() {
  allplats=$(grep -v '^#' plat.conf | grep -v "^-" | cut -d "|" -f 1)
  for plat in  $allplats
  do
    if [ "$plat" ] ; then
      testplat $plat
    fi
  done
}

_pullgit() {
  git checkout status/* >/dev/null 2>&1
  git checkout *.md >/dev/null 2>&1
  git checkout plat.conf >/dev/null 2>&1
  git pull >/dev/null 2>&1
}

_cron() {
  if [ "$CI" = "1" ]; then
    _pullgit
    rm "$Table"
  fi
  _FAILED_PLATS=""
  testall
  if [ "$_FAILED_PLATS" ] ; then
    _info "Let's try once more for: $_FAILED_PLATS"
    _ttft="$_FAILED_PLATS"
    _FAILED_PLATS=""
    testplats "$_ttft"
  fi
}


if [ -z "$1" ] ; then
  showhelp
else
  "$@"
fi




