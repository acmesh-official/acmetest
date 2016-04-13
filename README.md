# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1459297348)|Wed Mar 30 00:22:28 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1460561558)|Wed Apr 13 15:32:38 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1460561932)|Wed Apr 13 15:38:52 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1460562633)|Wed Apr 13 15:50:33 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1460563379)|Wed Apr 13 16:02:59 UTC 2016| Failed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1460564192)|Wed Apr 13 16:16:32 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1460564877)|Wed Apr 13 16:27:57 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1460565177)|Wed Apr 13 16:32:57 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1460565577)|Wed Apr 13 16:39:37 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1460565959)|Wed Apr 13 16:45:59 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1460566338)|Wed Apr 13 16:52:18 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1460566709)|Wed Apr 13 16:58:29 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1460567104)|Wed Apr 13 17:05:04 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1460567543)|Wed Apr 13 17:12:23 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1460567950)|Wed Apr 13 17:19:10 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1460568342)|Wed Apr 13 17:25:42 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1460568744)|Wed Apr 13 17:32:24 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1460569112)|Wed Apr 13 17:38:32 UTC 2016| Passed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1460569724)|Wed Apr 13 17:48:44 UTC 2016| Passed |
|alpine:3.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1460570039)|Wed Apr 13 17:53:59 UTC 2016| Passed |
|alpine:3.3|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1460570377)|Wed Apr 13 17:59:37 UTC 2016| Passed |
|alpine:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1460570709)|Wed Apr 13 18:05:09 UTC 2016| Passed |
|oraclelinux:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-6.svg?1460571120)|Wed Apr 13 18:12:00 UTC 2016| Passed |
|oraclelinux:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-7.svg?1460571575)|Wed Apr 13 18:19:35 UTC 2016| Passed |
|oraclelinux:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-latest.svg?1460571978)|Wed Apr 13 18:26:18 UTC 2016| Passed |
|kalilinux/kali-linux-docker|![](https://cdn.rawgit.com/Neilpang/letest/master/status/kalilinux-kali-linux-docker.svg?1460572416)|Wed Apr 13 18:33:36 UTC 2016| Passed |
|base/archlinux|![](https://cdn.rawgit.com/Neilpang/letest/master/status/base-archlinux.svg?1460572796)|Wed Apr 13 18:39:56 UTC 2016| Passed |
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






