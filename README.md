# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?Wed, 09 Nov 2016 16:50:57 UTC)| Wed, 09 Nov 2016 16:50:57 UTC| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?Wed, 09 Nov 2016 08:07:14 UTC)| Wed, 09 Nov 2016 08:07:14 UTC| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?Wed, 09 Nov 2016 16:15:54 UTC)| Wed, 09 Nov 2016 16:15:54 UTC| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?Wed, 09 Nov 2016 16:21:43 UTC)| Wed, 09 Nov 2016 16:21:43 UTC| Passed |
|solaris| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?Wed, 09 Nov 2016 16:32:37 GMT)| Wed, 09 Nov 2016 16:32:37 GMT| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?Wed, 09 Nov 2016 16:55:52 UTC)| Wed, 09 Nov 2016 16:55:52 UTC| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?Wed, 09 Nov 2016 17:00:45 UTC)| Wed, 09 Nov 2016 17:00:45 UTC| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?Wed, 09 Nov 2016 17:05:45 UTC)| Wed, 09 Nov 2016 17:05:45 UTC| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?Wed, 09 Nov 2016 17:10:41 UTC)| Wed, 09 Nov 2016 17:10:41 UTC| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?Wed, 09 Nov 2016 17:15:13 UTC)| Wed, 09 Nov 2016 17:15:13 UTC| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?Wed, 09 Nov 2016 17:20:10 UTC)| Wed, 09 Nov 2016 17:20:10 UTC| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?Wed, 09 Nov 2016 17:24:58 UTC)| Wed, 09 Nov 2016 17:24:58 UTC| Passed |
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









