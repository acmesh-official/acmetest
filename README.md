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
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1475330201)| Sat Oct  1 13:56:41 UTC 2016| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1475330298)| Sat Oct  1 13:58:18 UTC 2016| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1475330412)| Sat Oct  1 14:00:12 UTC 2016| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1475330522)| Sat Oct  1 14:02:02 UTC 2016| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1475331940)| Sat Oct  1 14:25:40 UTC 2016| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1475332039)| Sat Oct  1 14:27:19 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1475332137)| Sat Oct  1 14:28:57 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1475332396)| Sat Oct  1 14:33:16 UTC 2016| Passed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1475332903)| Sat Oct  1 14:41:43 UTC 2016| Passed |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1475314330)| Sat Oct  1 09:32:10 UTC 2016| Failed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1475315860)| Sat Oct  1 09:57:40 UTC 2016| Failed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1475317378)| Sat Oct  1 10:22:58 UTC 2016| Failed |
|fedora:22| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1475318873)| Sat Oct  1 10:47:53 UTC 2016| Failed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1475320356)| Sat Oct  1 11:12:36 UTC 2016| Failed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1475321839)| Sat Oct  1 11:37:19 UTC 2016| Failed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1475323220)| Sat Oct  1 12:00:20 UTC 2016| Passed |
|opensuse:42.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1475323691)| Sat Oct  1 12:08:11 UTC 2016| Passed |
|opensuse:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1475324157)| Sat Oct  1 12:15:57 UTC 2016| Passed |
|alpine:3.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1475324635)| Sat Oct  1 12:23:55 UTC 2016| Failed |
|alpine:3.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1475325112)| Sat Oct  1 12:31:52 UTC 2016| Failed |
|alpine:3.3| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1475325587)| Sat Oct  1 12:39:47 UTC 2016| Failed |
|alpine:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1475326064)| Sat Oct  1 12:47:44 UTC 2016| Failed |
|oraclelinux:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-6.svg?1475326514)| Sat Oct  1 12:55:14 UTC 2016| Failed |
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









