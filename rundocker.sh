
LeTest="https://github.com/Neilpang/letest.git"


Log_Err="err.log"

Conf="plat.conf"


#update plat code
update() {
  statusfile="$(echo "$1" | tr ':/ ' '---' )"
  if [ "$2" == "0" ] ; then
    if [ -f "status/ok.svg" ] ; then
    cp "status/ok.svg" "status/$statusfile.svg"
    fi
    __ok "$1"

  else
    if [ -f "status/ng.svg" ] ; then
      cp "status/ng.svg" "status/$statusfile.svg"
    fi
    __fail "$1"
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
  
  myplat="my$plat"
  
  platline="$(grep "^$plat[^ |]*" "$Conf" | tr -d "\r\n")"
  _debug "platline" "$platline"
  
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

  if [ "$DEBUG" ] ; then
    cat "$myplat/Dockerfile"
  fi
  
  if ! docker build -t "$myplat"  "$myplat" >"$Log_Err" 2>&1 ; then
    cat "$Log_Err"
    return 1
  fi
  if ! docker run -p 80:80 -e TestingDomain=$TestingDomain -e TestingAltDomains=$TestingAltDomains -e FORCE=1 -v $(pwd):/letest $myplat /bin/sh -c "cd /letest && ./letest.sh" >"$Log_Err" 2>&1 ; then
    cat "$Log_Err"
    
    if [ "$DEBUGING" ] ; then
      _info "Please debuging:"
      docker run -p 80:80 -i -t -e TestingDomain=$TestingDomain -e TestingAltDomains=$TestingAltDomains -e FORCE=1 -v $(pwd):/letest $myplat /bin/sh -c "cd /letest"
    fi
  fi
  code="$?"
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
  _debug "$platforms"

  for plat in $platforms 
  do 
    _runplat "$plat"
  done
}


testubuntu() {
  testplat "ubuntu"
}

testdebian() {
  testplat "debian"
}

#centos and fedora
testcentos() {
  testplat "centos"
}

#centos and fedora
testfedora() {
  testplat "fedora"
}

testopensuse() {
  testplat "opensuse"
}

testalpine() {
  testplat "alpine"
}

cleardocker() {
  docker rm $(docker ps -a -q)
  #docker rmi $(docker images -q -f "dangling=true")
}


showhelp() {
  _info "testall|testplat|testubuntu|testdebian|testcentos|testfedora|testopensuse|testalpine|cleardocker"
}


testall() {
  testubuntu
  testdebian
  testcentos
  testfedora
  testopensuse
  testalpine
}


if [ -z "$1" ] ; then
  showhelp
else
  "$@"
fi




