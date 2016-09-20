# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1471765173)| Sun Aug 21 07:39:33 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1470838591)| Wed Aug 10 14:16:31 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1470553409)| Sun Aug  7 07:03:29 UTC 2016| Passed |
|solaris| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?1470880346)| Thursday, August 11, 2016 01:52:26 AM GMT| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1474370307)| Tue Sep 20 11:18:27 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1474371043)| Tue Sep 20 11:30:43 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1474371219)| Tue Sep 20 11:33:39 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1474371398)| Tue Sep 20 11:36:38 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1474371550)| Tue Sep 20 11:39:10 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1474371709)| Tue Sep 20 11:41:49 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1474371864)| Tue Sep 20 11:44:24 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1474372078)| Tue Sep 20 11:47:58 UTC 2016| Failed |
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









