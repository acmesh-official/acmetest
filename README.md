# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?Fri, 11 Nov 2016 17:49:06 UTC)| Fri, 11 Nov 2016 17:49:06 UTC| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?Fri, 11 Nov 2016 09:05:37 UTC)| Fri, 11 Nov 2016 09:05:37 UTC| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?Fri, 11 Nov 2016 17:14:45 UTC)| Fri, 11 Nov 2016 17:14:45 UTC| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?Fri, 11 Nov 2016 17:20:13 UTC)| Fri, 11 Nov 2016 17:20:13 UTC| Passed |
|solaris| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?Fri, 11 Nov 2016 17:31:07 GMT)| Fri, 11 Nov 2016 17:31:07 GMT| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?Fri, 11 Nov 2016 17:53:57 UTC)| Fri, 11 Nov 2016 17:53:57 UTC| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?Fri, 11 Nov 2016 17:58:15 UTC)| Fri, 11 Nov 2016 17:58:15 UTC| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?Fri, 11 Nov 2016 18:03:06 UTC)| Fri, 11 Nov 2016 18:03:06 UTC| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?Fri, 11 Nov 2016 18:08:14 UTC)| Fri, 11 Nov 2016 18:08:14 UTC| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?Fri, 11 Nov 2016 18:12:55 UTC)| Fri, 11 Nov 2016 18:12:55 UTC| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?Fri, 11 Nov 2016 18:22:08 UTC)| Fri, 11 Nov 2016 18:22:08 UTC| Passed |
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









