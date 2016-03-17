# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg)|Thu Mar 17 14:14:51 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg)|Thu Mar 17 14:16:18 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg)|Thu Mar 17 14:17:45 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg)|Thu Mar 17 14:19:11 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg)|Thu Mar 17 14:20:39 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg)|Thu Mar 17 14:22:10 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg)|Thu Mar 17 14:23:47 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg)|Thu Mar 17 14:25:15 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg)|Thu Mar 17 14:26:48 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg)|Thu Mar 17 14:28:24 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg)|Thu Mar 17 14:29:59 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg)|Thu Mar 17 14:31:34 UTC 2016| Passed |
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






