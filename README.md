# acmetest
Unit test project for **acme.sh** project https://github.com/acmesh-official/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://acmesh-official.github.io/acmetest/status/freebsd.svg?1586458932)| Thu, 09 Apr 2020 19:02:12 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://acmesh-official.github.io/acmetest/status/openbsd.svg?1586488047)| Fri, 10 Apr 2020 03:07:27 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://acmesh-official.github.io/acmetest/status/pfsense.svg?1586488348)| Fri, 10 Apr 2020 03:12:28 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://acmesh-official.github.io/acmetest/status/solaris.svg?1583464630)| Fri, 06 Mar 2020 03:17:10 GMT| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://acmesh-official.github.io/acmetest/status/windows-cygwin.svg?1586489287)| Fri, 10 Apr 2020 03:28:07 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://acmesh-official.github.io/acmetest/status/ubuntu-latest.svg?1586489529)| Fri, 10 Apr 2020 03:32:09 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:latest| ![](https://acmesh-official.github.io/acmetest/status/debian-latest.svg?1586489729)| Fri, 10 Apr 2020 03:35:29 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/debian-latest.out) |
|centos:latest| ![](https://acmesh-official.github.io/acmetest/status/centos-latest.svg?1586489948)| Fri, 10 Apr 2020 03:39:08 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/centos-latest.out) |
|fedora:latest| ![](https://acmesh-official.github.io/acmetest/status/fedora-latest.svg?1586490151)| Fri, 10 Apr 2020 03:42:31 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/fedora-latest.out) |
|opensuse/leap| ![](https://acmesh-official.github.io/acmetest/status/opensuse-leap.svg?1586490169)| Fri, 10 Apr 2020 03:42:49 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/opensuse-leap.out) |
|alpine:latest| ![](https://acmesh-official.github.io/acmetest/status/alpine-latest.svg?1586490333)| Fri, 10 Apr 2020 03:45:33 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/alpine-latest.out) |

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








