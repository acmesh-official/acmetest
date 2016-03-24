# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1458715683)|Wed Mar 23 06:48:03 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1458830080)|Thu Mar 24 14:34:40 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1458830171)|Thu Mar 24 14:36:11 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1458830259)|Thu Mar 24 14:37:39 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1458830371)|Thu Mar 24 14:39:31 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1458830488)|Thu Mar 24 14:41:28 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1458830579)|Thu Mar 24 14:42:59 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1458830691)|Thu Mar 24 14:44:51 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1458830786)|Thu Mar 24 14:46:26 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1458830896)|Thu Mar 24 14:48:16 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1458831001)|Thu Mar 24 14:50:01 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1458831107)|Thu Mar 24 14:51:47 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1458831212)|Thu Mar 24 14:53:32 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1458831315)|Thu Mar 24 14:55:15 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1458831416)|Thu Mar 24 14:56:56 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1458831504)|Thu Mar 24 14:58:24 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1458831617)|Thu Mar 24 15:00:17 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg?1458831711)|Thu Mar 24 15:01:51 UTC 2016| Passed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg?1458831795)|Thu Mar 24 15:03:15 UTC 2016| Passed |
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






