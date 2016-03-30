
LeTest="https://github.com/Neilpang/letest.git"

Img="https://cdn.rawgit.com/Neilpang/letest/master/status"
Log_Err="err.log"

Conf="plat.conf"

Table="table.md"


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
  set +H
  if [ "$code" == "0" ] ; then
    if [ "$CI" ] ; then
      if [ -f "status/ok.svg" ] ; then
        cat "status/ok.svg" > "status/$statusfile.svg"
      fi
      _setopt "$filename" "|$plat|" "![]($Img/$statusfile.svg?$(date -u "+%s"))|" "$(date -u)| Passed |"
    fi
    __ok "$plat"

  else
    if [ "$CI" ] ; then
      if [ -f "status/ng.svg" ] ; then
        cat "status/ng.svg" > "status/$statusfile.svg"
      fi
      _setopt "$filename" "|$plat|" "![]($Img/$statusfile.svg?$(date -u "+%s"))|" "$(date -u)| Failed |"
    fi
    __fail "$plat"
  fi
  
  if [ "$CI" ] ; then
    git add "status/$statusfile.svg" >/dev/null 2>&1
    git add "$filename" >/dev/null 2>&1
    cat head.md "$Table" tail.md > README.md
    git add *.md >/dev/null 2>&1
    git commit -m "Test for $plat" >/dev/null 2>&1
    git pull >/dev/null 2>&1
    if ! git push >/dev/null 2>&1 ; then 
      _err "git push error"
    fi
  fi
}

#options file
_sed_i() {
  options="$1"
  filename="$2"
  if [ -z "$filename" ] ; then
    _err "Usage:_sed_i options filename"
    return 1
  fi
  
  if sed -h 2>&1 | grep "\-i[SUFFIX]" ; then
    _debug "Using sed  -i"
    sed -i ""
  else
    _debug "No -i support in sed"
    text="$(cat $filename)"
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

  if grep -H -n "^$__opt" "$__conf" > /dev/null ; then
    _debug OK
    if [[ "$__val" == *"&"* ]] ; then
      __val="$(echo $__val | sed 's/&/\\&/g')"
    fi
    set +H
    _sed_i "s\\^$__opt.*$\\$__opt$__sep$__val$__end\\"  "$__conf"

  else
    _debug APP
    echo "$__opt$__sep$__val$__end" >> "$__conf"
  fi

}

_info() {
  echo -e $1
}

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

__ok() {
  _info "$1 [\u001B[32mPASS\u001B[0m]"
}

__fail() {
  _err "$1 [\u001B[31mFAIL\u001B[0m]"
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
  if [[ "$plat" == *":"* ]] ; then
    basetag="$(echo "$plat" | cut -d : -f 1)"
    _debug "basetag" "$basetag"
    baseline="$(grep "^-$basetag[^ |]*" "$Conf" | tr -d "\r\n" )"
  fi
  _debug "baseline" "$baseline"

  _info "Running $plat, this may take a few minutes, please wait."
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
  
  if ! docker build -t "$myplat"  "$myplat" >"$Log_Err" 2>&1 ; then
    cat "$Log_Err"
    return 1
  fi

  if [ "$DEBUG" ] ; then
    docker run -p 80:80 --rm \
    -e TestingDomain=$TestingDomain \
    -e TestingAltDomains=$TestingAltDomains \
    -e DEBUG=$DEBUG \
    -v $(pwd):/letest $myplat /bin/sh -c "cd /letest && ./letest.sh"
    
  else
    if [ "$DEBUGING" ] ; then
      docker run -p 80:80 --rm \
      -e TestingDomain=$TestingDomain \
      -e TestingAltDomains=$TestingAltDomains \
      -v $(pwd):/letest \
      $myplat /bin/sh -c "cd /letest && ./letest.sh"
    else
      docker run -p 80:80 --rm \
      -e TestingDomain=$TestingDomain \
      -e TestingAltDomains=$TestingAltDomains \
      -v $(pwd):/letest \
      $myplat /bin/sh -c "cd /letest && ./letest.sh" >"$Log_Err" 2>&1
    fi
  fi
  code="$?"
  _debug "code" "$code"
 
  if [ "$code" != "0" ] ; then
    cat "$Log_Err"
    if [ "$DEBUGING" ] ; then
      _info "Please debuging:"
      docker run -p 80:80 --rm \
      -i -t \
      -e TestingDomain=$TestingDomain \
      -e TestingAltDomains=$TestingAltDomains \
      -v $(pwd):/letest $myplat /bin/sh
    fi
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



if [ -z "$1" ] ; then
  showhelp
else
  "$@"
fi




