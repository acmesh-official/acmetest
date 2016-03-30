# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1459297348)|Wed Mar 30 00:22:28 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1459337177)|Wed Mar 30 11:26:17 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1459337279)|Wed Mar 30 11:27:59 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1459337370)|Wed Mar 30 11:29:30 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1459337463)|Wed Mar 30 11:31:03 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1459337568)|Wed Mar 30 11:32:48 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1459337660)|Wed Mar 30 11:34:20 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1459337760)|Wed Mar 30 11:36:00 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1459337854)|Wed Mar 30 11:37:34 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1459337949)|Wed Mar 30 11:39:09 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1459338041)|Wed Mar 30 11:40:41 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1459338142)|Wed Mar 30 11:42:22 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1459338245)|Wed Mar 30 11:44:05 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1459338344)|Wed Mar 30 11:45:44 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1459338450)|Wed Mar 30 11:47:30 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1459338537)|Wed Mar 30 11:48:57 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1459338623)|Wed Mar 30 11:50:23 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1459338708)|Wed Mar 30 11:51:48 UTC 2016| Passed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1459338787)|Wed Mar 30 11:53:07 UTC 2016| Passed |
|alpine:3.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1459338865)|Wed Mar 30 11:54:25 UTC 2016| Passed |
|alpine:3.3|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1459338943)|Wed Mar 30 11:55:43 UTC 2016| Passed |
|alpine:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1459339021)|Wed Mar 30 11:57:01 UTC 2016| Passed |
|oraclelinux:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-6.svg?1459339113)|Wed Mar 30 11:58:33 UTC 2016| Passed |
|oraclelinux:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-7.svg?1459339221)|Wed Mar 30 12:00:21 UTC 2016| Passed |
|oraclelinux:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-latest.svg?1459339347)|Wed Mar 30 12:02:27 UTC 2016| Passed |
|kalilinux/kali-linux-docker|![](https://cdn.rawgit.com/Neilpang/letest/master/status/kalilinux-kali-linux-docker.svg?1459339458)|Wed Mar 30 12:04:18 UTC 2016| Passed |
|base/archlinux|![](https://cdn.rawgit.com/Neilpang/letest/master/status/base-archlinux.svg?1459339553)|Wed Mar 30 12:05:53 UTC 2016| Passed |
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






