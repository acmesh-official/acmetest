# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1476949151)| Thu Oct 20 07:39:11 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1476978748)| Thu Oct 20 15:52:28 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1476979374)| Thu Oct 20 16:02:54 UTC 2016| Passed |
|solaris| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?1470880346)| Thursday, August 11, 2016 01:52:26 AM GMT| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1476979866)| Thu Oct 20 16:11:06 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1476980354)| Thu Oct 20 16:19:14 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1476980902)| Thu Oct 20 16:28:22 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1476981435)| Thu Oct 20 16:37:15 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1476981906)| Thu Oct 20 16:45:06 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1476982404)| Thu Oct 20 16:53:24 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1476982898)| Thu Oct 20 17:01:38 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1476983673)| Thu Oct 20 17:14:33 UTC 2016| Failed |
|centos:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1476984285)| Thu Oct 20 17:24:45 UTC 2016| Passed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1476984940)| Thu Oct 20 17:35:40 UTC 2016| Passed |
|centos:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1476985599)| Thu Oct 20 17:46:39 UTC 2016| Passed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1476986560)| Thu Oct 20 18:02:40 UTC 2016| Failed |
|fedora:22| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1476987118)| Thu Oct 20 18:11:58 UTC 2016| Passed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1476988199)| Thu Oct 20 18:29:59 UTC 2016| Failed |
|fedora:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1476988748)| Thu Oct 20 18:39:08 UTC 2016| Passed |
|opensuse:13.2| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1476989284)| Thu Oct 20 18:48:04 UTC 2016| Passed |
|opensuse:42.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1476989747)| Thu Oct 20 18:55:47 UTC 2016| Passed |
|opensuse:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1476990222)| Thu Oct 20 19:03:42 UTC 2016| Passed |
|alpine:3.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1476990611)| Thu Oct 20 19:10:11 UTC 2016| Passed |
|alpine:3.2| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1476991000)| Thu Oct 20 19:16:40 UTC 2016| Passed |
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









