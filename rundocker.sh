
LeTest="https://github.com/Neilpang/letest.git"


#update plat
update() {
  if [ "$?" == "0" ] ; then
    __ok "$1"
  else
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

__ok() {
  _info "$1 [\u001B[32mPASS\u001B[0m]"
}

__fail() {
  _err "$1 [\u001B[31mFAIL\u001B[0m]"
  return 1
}

#myplat plat
_runplat() {
  myplat="$1"
  plat="$2"

  if [ "$DEBUG" ] ; then
    docker build -t "$myplat"  "$myplat"
    docker run -p 80:80 -e DEBUG=$DEBUG -e TestingDomain=$TestingDomain -e TestingAltDomains=$TestingAltDomains -e FORCE=1 -v $(pwd):/letest $myplat /bin/bash -c "/letest/letest.sh"
  else
    docker build -t "$myplat"  "$myplat" >/dev/null
    docker run -p 80:80 -e TestingDomain=$TestingDomain -e TestingAltDomains=$TestingAltDomains -e FORCE=1 -v $(pwd):/letest $myplat /bin/bash -c "/letest/letest.sh" >/dev/null 2>&1
  fi
  update $plat

}

_testubuntusub() {
  plat="$1"
  _info "Running $plat, this may take a few minutes, please wait."
  myplat="le$plat"
  mkdir -p "$myplat"
  echo "FROM $plat
RUN apt-get -qqy update >/dev/null 2>&1
RUN apt-get -qqy install openssl >/dev/null 2>&1
RUN apt-get -qqy install netcat >/dev/null 2>&1
RUN apt-get -qqy install cron >/dev/null 2>&1
RUN apt-get -qqy install curl >/dev/null 2>&1
RUN apt-get -qqy install git >/dev/null 2>&1
" > "$myplat/Dockerfile"

  _runplat "$myplat" "$plat"
}

#ubuntu and debian
testubuntu() {
  plat="$1"
  if [ "$plat" ] ; then
    _testubuntusub "$plat"
    return
  fi

  platforms="ubuntu:14.04 ubuntu:15.04 ubuntu:latest debian:6 debian:7 debian:8 debian:latest"

  for plat in $platforms 
  do 
    _testubuntusub "$plat"
  done
}


_testcentossub() {
  plat="$1"
  _info "Running $plat"
  myplat="le$plat"
  mkdir -p "$myplat"
  echo "FROM $plat
RUN yum -q -y update >/dev/null 2>&1
RUN yum -q -y install openssl >/dev/null 2>&1
RUN yum -q -y install crontabs >/dev/null 2>&1
RUN yum -q -y install nc >/dev/null 2>&1
RUN yum -q -y install curl >/dev/null 2>&1
RUN yum -q -y install git >/dev/null 2>&1
RUN yum -q -y install iproute >/dev/null 2>&1
" > "$myplat/Dockerfile"
  _runplat "$myplat" "$plat"
}

#centos and fedora
testcentos() {
  plat="$1"
  if [ "$plat" ] ; then
    _testcentossub "$plat"
    return
  fi
  
  platforms="centos:5 centos:6 centos:7 centos:latest"

  for plat in $platforms 
  do 
    _testcentossub "$plat"
  done

}

_testfedorasub() {
    plat="$1"
    _info "Running $plat"
    myplat="le$plat"
    mkdir -p "$myplat"
    echo "FROM $plat
RUN yum -q -y update >/dev/null 2>&1
RUN yum -q -y install openssl >/dev/null 2>&1
RUN yum -q -y install crontabs >/dev/null 2>&1
RUN yum -q -y install nc >/dev/null 2>&1
RUN yum -q -y install curl >/dev/null 2>&1
RUN yum -q -y install git >/dev/null 2>&1
RUN yum -q -y install iproute >/dev/null 2>&1

" > "$myplat/Dockerfile"
    _runplat "$myplat" "$plat"
}

#centos and fedora
testfedora() {
  plat="$1"
  if [ "$plat" ] ; then
    _testfedorasub "$plat"
    return
  fi
  platforms="fedora:21 fedora:22 fedora:23 fedora:latest"

  for plat in $platforms 
  do 
    _testfedorasub "$plat"
  done

}

cleardocker() {
  docker rm $(docker ps -a -q)
  #docker rmi $(docker images -q -f "dangling=true")
}


showhelp() {
  _info "testall|testubuntu|testcentos|testfedora|cleardocker"
}


testall() {
  testubuntu
  testcentos
  testfedora
}


if [ -z "$1" ] ; then
  showhelp
else
  "$@"
fi




