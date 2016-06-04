# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1465015684)| Sat Jun  4 04:48:04 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1465044824)| Sat Jun  4 12:53:44 UTC 2016| Passed |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/pfsense.svg?1465046607)| Sat Jun  4 13:23:27 UTC 2016| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1465048951)| Sat Jun  4 14:02:31 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1465049226)| Sat Jun  4 14:07:06 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1465049527)| Sat Jun  4 14:12:07 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1465049828)| Sat Jun  4 14:17:08 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1465050100)| Sat Jun  4 14:21:40 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1465050367)| Sat Jun  4 14:26:07 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1465050631)| Sat Jun  4 14:30:31 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1465050953)| Sat Jun  4 14:35:53 UTC 2016| Failed |
|centos:6| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1465051225)| Sat Jun  4 14:40:25 UTC 2016| Passed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1465051516)| Sat Jun  4 14:45:16 UTC 2016| Passed |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1465052096)| Sat Jun  4 14:54:56 UTC 2016| Passed |
|fedora:21| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1465052384)| Sat Jun  4 14:59:44 UTC 2016| Passed |
|fedora:22| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1465052670)| Sat Jun  4 15:04:30 UTC 2016| Passed |
|fedora:23| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1465053187)| Sat Jun  4 15:13:07 UTC 2016| Passed |
|fedora:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1465053486)| Sat Jun  4 15:18:06 UTC 2016| Failed |
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






