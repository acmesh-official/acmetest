# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1459297348)|Wed Mar 30 00:22:28 UTC 2016| Passed |
|freebsd|![](https://cdn.rawgit.com/Neilpang/letest/master/status/freebsd.svg?1458717740)|Wed Mar 23 07:22:20 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1460652272)|Thu Apr 14 16:44:32 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1460652632)|Thu Apr 14 16:50:32 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1460652976)|Thu Apr 14 16:56:16 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1460653718)|Thu Apr 14 17:08:38 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1460654091)|Thu Apr 14 17:14:51 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1460654464)|Thu Apr 14 17:21:04 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1460654763)|Thu Apr 14 17:26:03 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1460655489)|Thu Apr 14 17:38:09 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1460655862)|Thu Apr 14 17:44:22 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1460656229)|Thu Apr 14 17:50:29 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1460656883)|Thu Apr 14 18:01:23 UTC 2016| Failed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1460657263)|Thu Apr 14 18:07:43 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1460657649)|Thu Apr 14 18:14:09 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1460658028)|Thu Apr 14 18:20:28 UTC 2016| Passed |
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






