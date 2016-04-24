# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1461388681)| Sat, Apr 23, 2016  5:18:01 AM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1461381345)| Sat Apr 23 03:15:45 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1461477451)| Sun Apr 24 05:57:31 UTC 2016| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1461496545)| Sun Apr 24 11:15:45 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1461496934)| Sun Apr 24 11:22:14 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1461497394)| Sun Apr 24 11:29:54 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1461497757)| Sun Apr 24 11:35:57 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1461498119)| Sun Apr 24 11:41:59 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1461498493)| Sun Apr 24 11:48:13 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1461498860)| Sun Apr 24 11:54:20 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1461499166)| Sun Apr 24 11:59:26 UTC 2016| Failed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1461499947)| Sun Apr 24 12:12:27 UTC 2016| Failed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1461500365)| Sun Apr 24 12:19:25 UTC 2016| Passed |
|centos:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1461500774)| Sun Apr 24 12:26:14 UTC 2016| Passed |
(The openssl in CentOS 5 doesn't support ECDSA, so the ECDSA test cases failed. However, RSA certificates are working there.)

# How to run tests

First point at least 2 of your domains to your machine, 
for example: `aa.com` and `www.aa.com`

And make sure 80 port is not used by anyone else.

```
cd letest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./letest.sh
```

# How to run tests in all the platforms through docker.

You must have docker installed, and also point 2 of your domains to your machine.

Then test all the platforms :

```
cd letest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./rundocker.sh  testall
```

The script will download all the supported platforms from the official docker hub, then run the test cases in all the supported platforms.






