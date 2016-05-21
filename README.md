# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1463794614)| Sat May 21 01:36:54 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1463823735)| Sat May 21 09:42:15 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1463825511)| Sat May 21 10:11:51 UTC 2016| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1463827215)| Sat May 21 10:40:15 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1463827471)| Sat May 21 10:44:31 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1463827745)| Sat May 21 10:49:05 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1463828022)| Sat May 21 10:53:42 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1463828269)| Sat May 21 10:57:49 UTC 2016| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1463828782)| Sat May 21 11:06:22 UTC 2016| Failed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1463829056)| Sat May 21 11:10:56 UTC 2016| Passed |
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






