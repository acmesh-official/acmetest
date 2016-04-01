# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1459297348)|Wed Mar 30 00:22:28 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1459527121)|Fri Apr  1 16:12:01 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1459527215)|Fri Apr  1 16:13:35 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1459527303)|Fri Apr  1 16:15:03 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1459527396)|Fri Apr  1 16:16:36 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1459527491)|Fri Apr  1 16:18:11 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1459527581)|Fri Apr  1 16:19:41 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1459527687)|Fri Apr  1 16:21:27 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1459527840)|Fri Apr  1 16:24:00 UTC 2016| Failed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1459527940)|Fri Apr  1 16:25:40 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1459528036)|Fri Apr  1 16:27:16 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1459528128)|Fri Apr  1 16:28:48 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1459528230)|Fri Apr  1 16:30:30 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1459528342)|Fri Apr  1 16:32:22 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1459528558)|Fri Apr  1 16:35:58 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1459528647)|Fri Apr  1 16:37:27 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1459528736)|Fri Apr  1 16:38:56 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1459528825)|Fri Apr  1 16:40:25 UTC 2016| Passed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1459528904)|Fri Apr  1 16:41:44 UTC 2016| Passed |
|alpine:3.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1459528981)|Fri Apr  1 16:43:01 UTC 2016| Passed |
|alpine:3.3|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1459529060)|Fri Apr  1 16:44:20 UTC 2016| Passed |
|alpine:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1459529139)|Fri Apr  1 16:45:39 UTC 2016| Passed |
|oraclelinux:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-6.svg?1459529236)|Fri Apr  1 16:47:16 UTC 2016| Passed |
|oraclelinux:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-7.svg?1459529331)|Fri Apr  1 16:48:51 UTC 2016| Passed |
|oraclelinux:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-latest.svg?1459529425)|Fri Apr  1 16:50:25 UTC 2016| Passed |
|kalilinux/kali-linux-docker|![](https://cdn.rawgit.com/Neilpang/letest/master/status/kalilinux-kali-linux-docker.svg?1459529534)|Fri Apr  1 16:52:14 UTC 2016| Passed |
|base/archlinux|![](https://cdn.rawgit.com/Neilpang/letest/master/status/base-archlinux.svg?1459529620)|Fri Apr  1 16:53:40 UTC 2016| Passed |
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






