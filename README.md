# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1458715683)|Wed Mar 23 06:48:03 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1459084847)|Sun Mar 27 13:20:47 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1459084941)|Sun Mar 27 13:22:21 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1459085033)|Sun Mar 27 13:23:53 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1459085125)|Sun Mar 27 13:25:25 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1459085217)|Sun Mar 27 13:26:57 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1459085307)|Sun Mar 27 13:28:27 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1459085411)|Sun Mar 27 13:30:11 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1459085501)|Sun Mar 27 13:31:41 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1459085595)|Sun Mar 27 13:33:15 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1459085686)|Sun Mar 27 13:34:46 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1459085898)|Sun Mar 27 13:38:18 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1459086137)|Sun Mar 27 13:42:17 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1459086382)|Sun Mar 27 13:46:22 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1459086475)|Sun Mar 27 13:47:55 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1459087777)|Sun Mar 27 14:09:37 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1459087976)|Sun Mar 27 14:12:56 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1459086514)|Sun Mar 27 13:48:34 UTC 2016| Failed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1459086596)|Sun Mar 27 13:49:56 UTC 2016| Passed |
|alpine:3.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg?1459086678)|Sun Mar 27 13:51:18 UTC 2016| Passed |
|alpine:3.3|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg?1459086758)|Sun Mar 27 13:52:38 UTC 2016| Passed |
|alpine:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg?1459086834)|Sun Mar 27 13:53:54 UTC 2016| Passed |
|oraclelinux:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-6.svg?1459086849)|Sun Mar 27 13:54:09 UTC 2016| Failed |
|oraclelinux:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-7.svg?1459086861)|Sun Mar 27 13:54:21 UTC 2016| Failed |
|oraclelinux:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/oraclelinux-latest.svg?1459086873)|Sun Mar 27 13:54:33 UTC 2016| Failed |
|kalilinux/kali-linux-docker|![](https://cdn.rawgit.com/Neilpang/letest/master/status/kalilinux-kali-linux-docker.svg?1459086982)|Sun Mar 27 13:56:22 UTC 2016| Passed |
|base/archlinux|![](https://cdn.rawgit.com/Neilpang/letest/master/status/base-archlinux.svg?1459087088)|Sun Mar 27 13:58:08 UTC 2016| Passed |
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






