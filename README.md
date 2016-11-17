# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?Thu, 17 Nov 2016 06:06:16 UTC)| Thu, 17 Nov 2016 06:06:16 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?Thu, 17 Nov 2016 06:14:07 UTC)| Thu, 17 Nov 2016 06:14:07 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?Thu, 17 Nov 2016 06:19:48 UTC)| Thu, 17 Nov 2016 06:19:48 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?Thu, 17 Nov 2016 06:31:02 GMT)| Thu, 17 Nov 2016 06:31:02 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?Thu, 17 Nov 2016 06:49:59 UTC)| Thu, 17 Nov 2016 06:49:59 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?Thu, 17 Nov 2016 06:54:41 UTC)| Thu, 17 Nov 2016 06:54:41 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-15.04.svg?Thu, 17 Nov 2016 06:59:20 UTC)| Thu, 17 Nov 2016 06:59:20 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-15.04.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?Thu, 17 Nov 2016 07:04:34 UTC)| Thu, 17 Nov 2016 07:04:34 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?Thu, 17 Nov 2016 07:09:43 UTC)| Thu, 17 Nov 2016 07:09:43 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?Thu, 17 Nov 2016 07:14:04 UTC)| Thu, 17 Nov 2016 07:14:04 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?Thu, 17 Nov 2016 07:18:53 UTC)| Thu, 17 Nov 2016 07:18:53 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-latest.svg?Thu, 17 Nov 2016 07:22:13 UTC)| Thu, 17 Nov 2016 07:22:13 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-5.svg?Thu, 17 Nov 2016 07:23:56 UTC)| Thu, 17 Nov 2016 07:23:56 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-5.out) |

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









