# acmetest
Unit test project for le project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1462640779)| Sat, May 07, 2016  5:06:19 PM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1462608812)| Sat May  7 08:13:32 UTC 2016| Passed |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/openbsd.svg?1462636523)| Sat May  7 15:55:23 UTC 2016| Passed |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1462691662)| Sun May  8 07:14:22 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1462692044)| Sun May  8 07:20:44 UTC 2016| Passed |
|ubuntu:16.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-16.04.svg?1462692512)| Sun May  8 07:28:32 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1462692889)| Sun May  8 07:34:49 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1462693264)| Sun May  8 07:41:04 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1462693649)| Sun May  8 07:47:29 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1462694031)| Sun May  8 07:53:51 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1462694319)| Sun May  8 07:58:39 UTC 2016| Failed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1462695064)| Sun May  8 08:11:04 UTC 2016| Failed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1462695466)| Sun May  8 08:17:46 UTC 2016| Passed |
|centos:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1462695866)| Sun May  8 08:24:26 UTC 2016| Passed |
|fedora:21| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1462696262)| Sun May  8 08:31:02 UTC 2016| Passed |
|fedora:22| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1462696629)| Sun May  8 08:37:09 UTC 2016| Passed |
|fedora:23| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1462697025)| Sun May  8 08:43:45 UTC 2016| Passed |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1462697808)| Sun May  8 08:56:48 UTC 2016| Passed |
|opensuse:13.2| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1462698484)| Sun May  8 09:08:04 UTC 2016| Passed |
|opensuse:42.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1462698860)| Sun May  8 09:14:20 UTC 2016| Passed |
|opensuse:latest| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1462699481)| Sun May  8 09:24:41 UTC 2016| Failed |
|alpine:3.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1462699781)| Sun May  8 09:29:41 UTC 2016| Passed |
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






