# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1478618798)| Tue Nov  8 15:26:38 UTC 2016| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1478587633)| Tue Nov  8 06:47:13 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1478616895)| Tue Nov  8 14:54:55 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1478617229)| Tue Nov  8 15:00:29 UTC 2016| Passed |
|solaris| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?1478617856)| Tuesday, November  8, 2016 03:10:56 PM GMT| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1478619061)| Tue Nov  8 15:31:01 UTC 2016| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1478619327)| Tue Nov  8 15:35:27 UTC 2016| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1478619617)| Tue Nov  8 15:40:17 UTC 2016| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1478620223)| Tue Nov  8 15:50:23 UTC 2016| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1478620512)| Tue Nov  8 15:55:12 UTC 2016| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1478620792)| Tue Nov  8 15:59:52 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1478621080)| Tue Nov  8 16:04:40 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1478621285)| Tue Nov  8 16:08:05 UTC 2016| Passed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1478621579)| Tue Nov  8 16:12:59 UTC 2016| Passed |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1478621882)| Tue Nov  8 16:18:02 UTC 2016| Passed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1478622193)| Tue Nov  8 16:23:13 UTC 2016| Passed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1478622497)| Tue Nov  8 16:28:17 UTC 2016| Passed |
|fedora:22| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1478622818)| Tue Nov  8 16:33:38 UTC 2016| Passed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1478623128)| Tue Nov  8 16:38:48 UTC 2016| Passed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1478623443)| Tue Nov  8 16:44:03 UTC 2016| Passed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1478623722)| Tue Nov  8 16:48:42 UTC 2016| Passed |
|opensuse:42.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1478623996)| Tue Nov  8 16:53:16 UTC 2016| Passed |
|opensuse:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1478624265)| Tue Nov  8 16:57:45 UTC 2016| Passed |
|alpine:3.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1478624506)| Tue Nov  8 17:01:46 UTC 2016| Passed |
|alpine:3.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1478624753)| Tue Nov  8 17:05:53 UTC 2016| Passed |
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









