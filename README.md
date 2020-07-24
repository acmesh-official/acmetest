# acmetest
Unit test project for **acme.sh** project https://github.com/acmesh-official/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://acmesh-official.github.io/acmetest/status/freebsd.svg?1595530931)| Thu, 23 Jul 2020 19:02:11 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://acmesh-official.github.io/acmetest/status/openbsd.svg?1595560045)| Fri, 24 Jul 2020 03:07:25 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://acmesh-official.github.io/acmetest/status/pfsense.svg?1595560321)| Fri, 24 Jul 2020 03:12:01 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://acmesh-official.github.io/acmetest/status/solaris.svg?1583464630)| Fri, 06 Mar 2020 03:17:10 GMT| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://acmesh-official.github.io/acmetest/status/windows-cygwin.svg?1595561261)| Fri, 24 Jul 2020 03:27:41 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://acmesh-official.github.io/acmetest/status/ubuntu-latest.svg?1595561477)| Fri, 24 Jul 2020 03:31:17 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:latest| ![](https://acmesh-official.github.io/acmetest/status/debian-latest.svg?1595561675)| Fri, 24 Jul 2020 03:34:35 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/debian-latest.out) |
|centos:latest| ![](https://acmesh-official.github.io/acmetest/status/centos-latest.svg?1595561889)| Fri, 24 Jul 2020 03:38:09 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/centos-latest.out) |
|fedora:latest| ![](https://acmesh-official.github.io/acmetest/status/fedora-latest.svg?1595562088)| Fri, 24 Jul 2020 03:41:28 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/fedora-latest.out) |
|opensuse/leap:latest| ![](https://acmesh-official.github.io/acmetest/status/opensuse-leap-latest.svg?1595562284)| Fri, 24 Jul 2020 03:44:44 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/opensuse-leap-latest.out) |
|alpine:latest| ![](https://acmesh-official.github.io/acmetest/status/alpine-latest.svg?1595562596)| Fri, 24 Jul 2020 03:49:56 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/alpine-latest.out) |
|oraclelinux:latest| ![](https://acmesh-official.github.io/acmetest/status/oraclelinux-latest.svg?1595562800)| Fri, 24 Jul 2020 03:53:20 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/oraclelinux-latest.out) |
|kalilinux/kali| ![](https://acmesh-official.github.io/acmetest/status/kalilinux-kali.svg?1595562992)| Fri, 24 Jul 2020 03:56:32 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/kalilinux-kali.out) |
|archlinux:latest| ![](https://acmesh-official.github.io/acmetest/status/archlinux-latest.svg?1595563222)| Fri, 24 Jul 2020 04:00:22 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/archlinux-latest.out) |
|mageia| ![](https://acmesh-official.github.io/acmetest/status/mageia.svg?1595563416)| Fri, 24 Jul 2020 04:03:36 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/mageia.out) |
|gentoo/stage3-amd64| ![](https://acmesh-official.github.io/acmetest/status/gentoo-stage3-amd64.svg?1595565316)| Fri, 24 Jul 2020 04:35:16 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/gentoo-stage3-amd64.out) |
|clearlinux:latest| ![](https://acmesh-official.github.io/acmetest/status/clearlinux-latest.svg?1595565528)| Fri, 24 Jul 2020 04:38:48 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/clearlinux-latest.out) |

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








