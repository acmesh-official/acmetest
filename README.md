# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows-cygwin.svg?1461388681)| Sat, Apr 23, 2016  5:18:01 AM| Passed |
|freebsd| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1461381345)| Sat Apr 23 03:15:45 UTC 2016| Passed |
|ubuntu:14.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1461410695)| Sat Apr 23 11:24:55 UTC 2016| Passed |
|ubuntu:15.04| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1461411061)| Sat Apr 23 11:31:01 UTC 2016| Passed |
|ubuntu:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1461411425)| Sat Apr 23 11:37:05 UTC 2016| Passed |
|debian:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1461411782)| Sat Apr 23 11:43:02 UTC 2016| Passed |
|debian:8| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1461412156)| Sat Apr 23 11:49:16 UTC 2016| Passed |
|debian:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1461412527)| Sat Apr 23 11:55:27 UTC 2016| Passed |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1461412837)| Sat Apr 23 12:00:37 UTC 2016| Failed |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1461413633)| Sat Apr 23 12:13:53 UTC 2016| Passed |
|centos:7| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1461414032)| Sat Apr 23 12:20:32 UTC 2016| Passed |
|centos:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1461414416)| Sat Apr 23 12:26:56 UTC 2016| Passed |
|fedora:21| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1461414793)| Sat Apr 23 12:33:13 UTC 2016| Passed |
|fedora:22| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1461415173)| Sat Apr 23 12:39:33 UTC 2016| Passed |
|fedora:23| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1461415550)| Sat Apr 23 12:45:50 UTC 2016| Passed |
|fedora:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1461415943)| Sat Apr 23 12:52:23 UTC 2016| Passed |
|opensuse:13.2| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1461416308)| Sat Apr 23 12:58:28 UTC 2016| Passed |
|opensuse:42.1| ![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1461417027)| Sat Apr 23 13:10:27 UTC 2016| Passed |
|opensuse:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1461417398)| Sat Apr 23 13:16:38 UTC 2016| Passed |
|alpine:3.1| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1461417704)| Sat Apr 23 13:21:44 UTC 2016| Passed |
|alpine:3.2| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1461417999)| Sat Apr 23 13:26:39 UTC 2016| Passed |
|alpine:3.3| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1461418284)| Sat Apr 23 13:31:24 UTC 2016| Passed |
|alpine:latest| \![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1461418563)| Sat Apr 23 13:36:03 UTC 2016| Passed |
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






