# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://neilpang.github.io/acmetest/status/freebsd.svg?1570755940)| Fri, 11 Oct 2019 01:05:40 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://neilpang.github.io/acmetest/status/openbsd.svg?1570756530)| Fri, 11 Oct 2019 01:15:30 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://neilpang.github.io/acmetest/status/pfsense.svg?1570757394)| Fri, 11 Oct 2019 01:29:54 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://neilpang.github.io/acmetest/status/solaris.svg?1570757931)| Fri, 11 Oct 2019 01:38:51 GMT| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://neilpang.github.io/acmetest/status/windows-cygwin.svg?1570759134)| Fri, 11 Oct 2019 01:58:54 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://neilpang.github.io/acmetest/status/ubuntu-latest.svg?1570759589)| Fri, 11 Oct 2019 02:06:29 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:18.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-18.04.svg?1570760421)| Fri, 11 Oct 2019 02:20:21 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-18.04.out) |
|ubuntu:16.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-16.04.svg?1570760855)| Fri, 11 Oct 2019 02:27:35 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-14.04.svg?1570761285)| Fri, 11 Oct 2019 02:34:45 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://neilpang.github.io/acmetest/status/debian-latest.svg?1570762090)| Fri, 11 Oct 2019 02:48:10 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:10| ![](https://neilpang.github.io/acmetest/status/debian-10.svg?1570762975)| Fri, 11 Oct 2019 03:02:55 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-10.out) |
|debian:9| ![](https://neilpang.github.io/acmetest/status/debian-9.svg?1570763404)| Fri, 11 Oct 2019 03:10:04 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://neilpang.github.io/acmetest/status/debian-8.svg?1570763830)| Fri, 11 Oct 2019 03:17:10 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://neilpang.github.io/acmetest/status/debian-7.svg?1570764253)| Fri, 11 Oct 2019 03:24:13 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |

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








