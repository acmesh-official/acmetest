
LeTest="https://github.com/Neilpang/letest.git"

Img="https://cdn.rawgit.com/Neilpang/letest/master/status"


Conf="plat.conf"

Table="table.md"

if [ -z "$TestingDomain" ] ; then
  TestingDomain=testdocker.acme.sh
fi

if [ -z "$TestingAltDomains" ] ; then
  TestingAltDomains=testdocker2.acme.sh
fi


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
  
  statusfile="$(echo "$plat" | tr ':/ \\' '----' )"

  if [ "$code" == "0" ] ; then
    __ok "$plat"
  else
    __fail "$plat"
  fi
  
  if [ "$CI" ] ; then
    if ! git pull >/dev/null 2>&1 ; then 
      _err "git pull error"
    fi
    _status="Passed"
    if [ "$code" == "0" ] ; then
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
    
    _setopt "$filename" "|$plat|" " " "\![]($Img/$statusfile.svg?$(date -u "+%s"))| $(date -u)| $_status |"
  
    git add "status/$statusfile.svg" >/dev/null 2>&1
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



__green() {
  printf '\033[1;31;32m'
  printf "$1"
  printf '\033[0m'
}

__ok() {
  __green "$1 [PASS]"
  printf "\n"
}

__red() {
  printf '\033[1;31;40m'
  printf "$1"
  printf '\033[0m'
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
  
  if [ "$update" ] ; then
    echo "RUN $update >/dev/null 2>&1" >>  "$myplat/Dockerfile"
  fi
  
  install="$(_mergefield "$platline" "$baseline" 3)"
  _debug "install" "$install"
  
  if [ "$install" ] ; then
    tools="$(_mergefield "$platline" "$baseline" 4)"
    if [ "$tools" ] ; then
      toolsline=$(echo "$tools" |  tr ',' ' ' )
      for tool in $toolsline   
      do
        if [ "$tool" ] ; then
          echo "RUN $install $tool >/dev/null 2>&1"  >>  "$myplat/Dockerfile"
        fi
      done
    fi
  fi

  if [ "$DEBUGING" ] ; then
    cat "$myplat/Dockerfile"
  fi
  
  statusfile="$(echo "$plat" | tr ':/ \\' '----' )"
  Log_Out="$statusfile.out"
  
  if docker build -t "$myplat"  "$myplat" >"$Log_Out" 2>&1 ; then

    if [ -z "$LOG_FILE" ] ; then
      LOG_FILE="$statusfile.log"
      rm -rf "$LOG_FILE"
    fi
    
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
      -v $(pwd):/acmetest \
      $myplat /bin/sh -c "cd /acmetest && ./letest.sh $CASE"
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
      -v $(pwd):/acmetest \
      $myplat /bin/sh -c "cd /acmetest && ./letest.sh $CASE" >>"$Log_Out" 2>&1
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
        -v $(pwd):/acmetest $myplat /bin/sh
      fi
    fi
  else
    code="$?"
    _debug "code" "$code"
    cat "$Log_Out"
    return 1
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
  
  platforms=$(grep -o "^$plat[^ |]*" "$Conf" )
  if [ ! "$platforms" ] ; then
    platforms="$plat"
  fi
  _debug "$platforms"

  for plat in $platforms 
  do 
    if ! _runplat "$plat" ; then
      if [ -z "$DEBUG" ] && [ -z "$DEBUGING" ] ; then
        _info "Let's retry once more:$plat"
        _runplat "$plat"
      fi
    fi
  done
}


cleardocker() {
  docker rm $(docker ps -a -q)
  #docker rmi $(docker images -q -f "dangling=true")
}


showhelp() {
  _info "testall|testplat|cleardocker|_cron"
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
  CI="1"
  _pullgit
  rm "$Table"
  testall
  CI=""
}

if [ "$CASE" ] ; then
  _info "Test for case: $(__green "$CASE")"
fi

if [ -z "$1" ] ; then
  showhelp
else
  "$@"
fi




