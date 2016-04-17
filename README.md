# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1459297348)|Wed Mar 30 00:22:28 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1460851568)|Sun Apr 17 00:06:08 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1460851928)|Sun Apr 17 00:12:08 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1460852281)|Sun Apr 17 00:18:01 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1460852634)|Sun Apr 17 00:23:54 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1460853007)|Sun Apr 17 00:30:07 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1460853370)|Sun Apr 17 00:36:10 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1460853669)|Sun Apr 17 00:41:09 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1460854032)|Sun Apr 17 00:47:12 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1460854418)|Sun Apr 17 00:53:38 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1460854791)|Sun Apr 17 00:59:51 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1460855164)|Sun Apr 17 01:06:04 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1460855533)|Sun Apr 17 01:12:13 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1460855908)|Sun Apr 17 01:18:28 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1460856287)|Sun Apr 17 01:24:47 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1460856641)|Sun Apr 17 01:30:41 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1460856993)|Sun Apr 17 01:36:33 UTC 2016| Passed |
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






