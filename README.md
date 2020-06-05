# acmetest
Unit test project for **acme.sh** project https://github.com/acmesh-official/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://acmesh-official.github.io/acmetest/status/freebsd.svg?1591297325)| Thu, 04 Jun 2020 19:02:05 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://acmesh-official.github.io/acmetest/status/openbsd.svg?1591326438)| Fri, 05 Jun 2020 03:07:18 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://acmesh-official.github.io/acmetest/status/pfsense.svg?1591326728)| Fri, 05 Jun 2020 03:12:08 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://acmesh-official.github.io/acmetest/status/solaris.svg?1583464630)| Fri, 06 Mar 2020 03:17:10 GMT| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://acmesh-official.github.io/acmetest/status/windows-cygwin.svg?1591327623)| Fri, 05 Jun 2020 03:27:03 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://acmesh-official.github.io/acmetest/status/ubuntu-latest.svg?1591327847)| Fri, 05 Jun 2020 03:30:47 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:latest| ![](https://acmesh-official.github.io/acmetest/status/debian-latest.svg?1591328050)| Fri, 05 Jun 2020 03:34:10 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/debian-latest.out) |
|centos:latest| ![](https://acmesh-official.github.io/acmetest/status/centos-latest.svg?1591328268)| Fri, 05 Jun 2020 03:37:48 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/centos-latest.out) |
|fedora:latest| ![](https://acmesh-official.github.io/acmetest/status/fedora-latest.svg?1591328474)| Fri, 05 Jun 2020 03:41:14 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/fedora-latest.out) |
|opensuse/leap| ![](https://acmesh-official.github.io/acmetest/status/opensuse-leap.svg?1591328490)| Fri, 05 Jun 2020 03:41:30 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/opensuse-leap.out) |
|alpine:latest| ![](https://acmesh-official.github.io/acmetest/status/alpine-latest.svg?1591328804)| Fri, 05 Jun 2020 03:46:44 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/alpine-latest.out) |
|oraclelinux:latest| ![](https://acmesh-official.github.io/acmetest/status/oraclelinux-latest.svg?1591329008)| Fri, 05 Jun 2020 03:50:08 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/oraclelinux-latest.out) |
|kalilinux/kali| ![](https://acmesh-official.github.io/acmetest/status/kalilinux-kali.svg?1591329205)| Fri, 05 Jun 2020 03:53:25 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/kalilinux-kali.out) |
|archlinux:latest| ![](https://acmesh-official.github.io/acmetest/status/archlinux-latest.svg?1591329225)| Fri, 05 Jun 2020 03:53:45 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/archlinux-latest.out) |
|mageia| ![](https://acmesh-official.github.io/acmetest/status/mageia.svg?1591329422)| Fri, 05 Jun 2020 03:57:02 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/mageia.out) |

# How to run tests

First point at least 2 of your domains to your machine, 
for example: `aa.com` and `www.aa.com`

And make sure 80 port is not used by anyone else.

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./letest.sh
```

# How to run tests in all the platforms through docker.

You must have docker installed, and also point 2 of your domains to your machine.

Then test all the platforms :

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./rundocker.sh  testall
```

The script will download all the supported platforms from the official docker hub, then run the test cases in all the supported platforms.

Then test single docker platform :

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./rundocker.sh  testplat   centos:latest
```

# Run tests with ngrok automatically

If you don't want to use 2 domains to test, we can use ngrok to test with temp domain.

Please register an free account at https://ngrok.com/

You will get your ngrok auth token.  Then:

```
export NGROK_TOKEN="xxxxxxxxxx"

./letest.sh

```








