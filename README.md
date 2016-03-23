# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|windows|![](https://cdn.rawgit.com/Neilpang/letest/master/status/windows.svg?1458715683)|Wed Mar 23 06:48:03 UTC 2016| Passed |
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg?1458744460)|Wed Mar 23 14:47:40 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg?1458744548)|Wed Mar 23 14:49:08 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg?1458744635)|Wed Mar 23 14:50:35 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg?1458744729)|Wed Mar 23 14:52:09 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg?1458744821)|Wed Mar 23 14:53:41 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg?1458744916)|Wed Mar 23 14:55:16 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg?1458745019)|Wed Mar 23 14:56:59 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg?1458745110)|Wed Mar 23 14:58:30 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg?1458745202)|Wed Mar 23 15:00:02 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg?1458745312)|Wed Mar 23 15:01:52 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg?1458745412)|Wed Mar 23 15:03:32 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg?1458745512)|Wed Mar 23 15:05:12 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg?1458745611)|Wed Mar 23 15:06:51 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg?1458745709)|Wed Mar 23 15:08:29 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg?1458745799)|Wed Mar 23 15:09:59 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg?1458745887)|Wed Mar 23 15:11:27 UTC 2016| Passed |
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






