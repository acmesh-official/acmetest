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






