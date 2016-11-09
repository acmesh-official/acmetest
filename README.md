# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?Wed, 09 Nov 2016 13:04:23 UTC)| Wed, 09 Nov 2016 13:04:23 UTC| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?Wed, 09 Nov 2016 04:21:09 UTC)| Wed, 09 Nov 2016 04:21:09 UTC| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?Wed, 09 Nov 2016 12:29:37 UTC)| Wed, 09 Nov 2016 12:29:37 UTC| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?Wed, 09 Nov 2016 12:35:23 UTC)| Wed, 09 Nov 2016 12:35:23 UTC| Failed |
|solaris| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?Wed, 09 Nov 2016 12:46:14 GMT)| Wed, 09 Nov 2016 12:46:14 GMT| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?Wed, 09 Nov 2016 13:08:57 UTC)| Wed, 09 Nov 2016 13:08:57 UTC| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?Wed, 09 Nov 2016 13:13:41 UTC)| Wed, 09 Nov 2016 13:13:41 UTC| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?Wed, 09 Nov 2016 13:18:46 UTC)| Wed, 09 Nov 2016 13:18:46 UTC| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?Wed, 09 Nov 2016 13:24:06 UTC)| Wed, 09 Nov 2016 13:24:06 UTC| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?Wed, 09 Nov 2016 13:28:40 UTC)| Wed, 09 Nov 2016 13:28:40 UTC| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?Wed, 09 Nov 2016 13:33:24 UTC)| Wed, 09 Nov 2016 13:33:24 UTC| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?Wed, 09 Nov 2016 13:38:07 UTC)| Wed, 09 Nov 2016 13:38:07 UTC| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?Wed, 09 Nov 2016 13:41:31 UTC)| Wed, 09 Nov 2016 13:41:31 UTC| Passed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?Wed, 09 Nov 2016 13:46:30 UTC)| Wed, 09 Nov 2016 13:46:30 UTC| Passed |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?Wed, 09 Nov 2016 13:51:31 UTC)| Wed, 09 Nov 2016 13:51:31 UTC| Passed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?Wed, 09 Nov 2016 13:56:50 UTC)| Wed, 09 Nov 2016 13:56:50 UTC| Passed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?Wed, 09 Nov 2016 14:01:50 UTC)| Wed, 09 Nov 2016 14:01:50 UTC| Passed |
|fedora:22| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?Wed, 09 Nov 2016 14:06:55 UTC)| Wed, 09 Nov 2016 14:06:55 UTC| Passed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?Wed, 09 Nov 2016 14:12:13 UTC)| Wed, 09 Nov 2016 14:12:13 UTC| Passed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?Wed, 09 Nov 2016 14:17:22 UTC)| Wed, 09 Nov 2016 14:17:22 UTC| Passed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?Wed, 09 Nov 2016 14:21:47 UTC)| Wed, 09 Nov 2016 14:21:47 UTC| Passed |
|opensuse:42.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?Wed, 09 Nov 2016 14:26:16 UTC)| Wed, 09 Nov 2016 14:26:16 UTC| Passed |
|opensuse:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?Wed, 09 Nov 2016 14:30:44 UTC)| Wed, 09 Nov 2016 14:30:44 UTC| Passed |
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









