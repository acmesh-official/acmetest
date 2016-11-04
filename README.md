# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1478256273)| Fri Nov  4 10:44:33 UTC 2016| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1478225159)| Fri Nov  4 02:05:59 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1478254412)| Fri Nov  4 10:13:32 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1478254729)| Fri Nov  4 10:18:49 UTC 2016| Passed |
|solaris| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/solaris.svg?1478255334)| Friday, November  4, 2016 10:28:54 AM GMT| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1478256521)| Fri Nov  4 10:48:41 UTC 2016| Passed |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1478256762)| Fri Nov  4 10:52:42 UTC 2016| Passed |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1478257050)| Fri Nov  4 10:57:30 UTC 2016| Passed |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1478257347)| Fri Nov  4 11:02:27 UTC 2016| Passed |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1478257608)| Fri Nov  4 11:06:48 UTC 2016| Passed |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1478258107)| Fri Nov  4 11:15:07 UTC 2016| Passed |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1478258378)| Fri Nov  4 11:19:38 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1478258567)| Fri Nov  4 11:22:47 UTC 2016| Passed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1478258834)| Fri Nov  4 11:27:14 UTC 2016| Passed |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1478259135)| Fri Nov  4 11:32:15 UTC 2016| Passed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1478259476)| Fri Nov  4 11:37:56 UTC 2016| Passed |
|fedora:21| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1478259800)| Fri Nov  4 11:43:20 UTC 2016| Passed |
|fedora:22| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1478260364)| Fri Nov  4 11:52:44 UTC 2016| Passed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1478260651)| Fri Nov  4 11:57:31 UTC 2016| Passed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1478260949)| Fri Nov  4 12:02:29 UTC 2016| Passed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1478261194)| Fri Nov  4 12:06:34 UTC 2016| Passed |
|opensuse:42.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1478261442)| Fri Nov  4 12:10:42 UTC 2016| Passed |
|opensuse:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1478261684)| Fri Nov  4 12:14:44 UTC 2016| Passed |
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









