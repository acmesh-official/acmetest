# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1466114181)| Thu Jun 16 21:56:21 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1466148414)| Fri Jun 17 07:26:54 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1466154740)| Fri Jun 17 09:12:20 UTC 2016| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1466156950)| Fri Jun 17 09:49:10 UTC 2016| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1466157630)| Fri Jun 17 10:00:30 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1466157991)| Fri Jun 17 10:06:31 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1466158347)| Fri Jun 17 10:12:27 UTC 2016| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1466158997)| Fri Jun 17 10:23:17 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1466159328)| Fri Jun 17 10:28:48 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1466159931)| Fri Jun 17 10:38:51 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1466160426)| Fri Jun 17 10:47:06 UTC 2016| Failed |
|centos:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1466160766)| Fri Jun 17 10:52:46 UTC 2016| Passed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1466161119)| Fri Jun 17 10:58:39 UTC 2016| Passed |
|centos:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1466161475)| Fri Jun 17 11:04:35 UTC 2016| Passed |
|fedora:21| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1466161825)| Fri Jun 17 11:10:25 UTC 2016| Passed |
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






