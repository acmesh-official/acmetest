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
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1475251156)| Fri Sep 30 15:59:16 UTC 2016| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1475252484)| Fri Sep 30 16:21:24 UTC 2016| Failed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1475253991)| Fri Sep 30 16:46:31 UTC 2016| Failed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1475255476)| Fri Sep 30 17:11:16 UTC 2016| Failed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1475256779)| Fri Sep 30 17:32:59 UTC 2016| Failed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1475258088)| Fri Sep 30 17:54:48 UTC 2016| Failed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1475259413)| Fri Sep 30 18:16:53 UTC 2016| Failed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1475260357)| Fri Sep 30 18:32:37 UTC 2016| Failed |
|centos:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1475260832)| Fri Sep 30 18:40:32 UTC 2016| Passed |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1475262297)| Fri Sep 30 19:04:57 UTC 2016| Failed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1475263765)| Fri Sep 30 19:29:25 UTC 2016| Failed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1475265233)| Fri Sep 30 19:53:53 UTC 2016| Failed |
|fedora:22| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1475266654)| Fri Sep 30 20:17:34 UTC 2016| Failed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1475268149)| Fri Sep 30 20:42:29 UTC 2016| Failed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1475269615)| Fri Sep 30 21:06:55 UTC 2016| Failed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1475270506)| Fri Sep 30 21:21:46 UTC 2016| Passed |
|opensuse:42.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1475271014)| Fri Sep 30 21:30:14 UTC 2016| Passed |
|opensuse:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1475271486)| Fri Sep 30 21:38:06 UTC 2016| Passed |
|alpine:3.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1475271963)| Fri Sep 30 21:46:03 UTC 2016| Failed |
|alpine:3.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1475272437)| Fri Sep 30 21:53:57 UTC 2016| Failed |
|alpine:3.3| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1475272906)| Fri Sep 30 22:01:46 UTC 2016| Failed |
|alpine:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1475273067)| Fri Sep 30 22:04:27 UTC 2016| Failed |
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









