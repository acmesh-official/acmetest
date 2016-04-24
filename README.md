# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1461388681)| Sat, Apr 23, 2016  5:18:01 AM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1461381345)| Sat Apr 23 03:15:45 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1461477451)| Sun Apr 24 05:57:31 UTC 2016| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1461508140)| Sun Apr 24 14:29:00 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1461508508)| Sun Apr 24 14:35:08 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1461508964)| Sun Apr 24 14:42:44 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1461509327)| Sun Apr 24 14:48:47 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1461509688)| Sun Apr 24 14:54:48 UTC 2016| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1461510470)| Sun Apr 24 15:07:50 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1461511211)| Sun Apr 24 15:20:11 UTC 2016| Failed |
|centos:5| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1461511372)| Sun Apr 24 15:22:52 UTC 2016| Failed |
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






