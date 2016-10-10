# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1475221605)| Fri Sep 30 07:46:45 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1474378907)| Tue Sep 20 13:41:47 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1470553409)| Sun Aug  7 07:03:29 UTC 2016| Passed |
|solaris| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?1470880346)| Thursday, August 11, 2016 01:52:26 AM GMT| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1476100506)| Mon Oct 10 11:55:06 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1476101121)| Mon Oct 10 12:05:21 UTC 2016| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1476102184)| Mon Oct 10 12:23:04 UTC 2016| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1476103278)| Mon Oct 10 12:41:18 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1476103820)| Mon Oct 10 12:50:20 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1476104421)| Mon Oct 10 13:00:21 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1476105460)| Mon Oct 10 13:17:40 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1476106236)| Mon Oct 10 13:30:36 UTC 2016| Failed |
|centos:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1476106813)| Mon Oct 10 13:40:13 UTC 2016| Passed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1476107371)| Mon Oct 10 13:49:31 UTC 2016| Passed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1476108540)| Mon Oct 10 14:09:00 UTC 2016| Passed |
|fedora:21| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1476109312)| Mon Oct 10 14:21:52 UTC 2016| Passed |
|fedora:22| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1476109988)| Mon Oct 10 14:33:08 UTC 2016| Passed |
|fedora:23| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1476110878)| Mon Oct 10 14:47:58 UTC 2016| Passed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1476112013)| Mon Oct 10 15:06:53 UTC 2016| Failed |
(The openssl in CentOS 5 doesn't support ECDSA, so the ECDSA test cases failed. However, RSA certificates are working there.)

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









