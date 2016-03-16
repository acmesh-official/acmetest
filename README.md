# letest
Unit test project for le project https://github.com/Neilpang/le



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|ubuntu:14.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-14.04.svg)|Wed Mar 16 14:26:02 UTC 2016| Passed |
|ubuntu:15.04|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-15.04.svg)|Wed Mar 16 14:26:56 UTC 2016| Passed |
|ubuntu:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/ubuntu-latest.svg)|Wed Mar 16 14:27:48 UTC 2016| Passed |
|debian:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-7.svg)|Wed Mar 16 14:28:40 UTC 2016| Passed |
|debian:8|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-8.svg)|Wed Mar 16 14:29:34 UTC 2016| Passed |
|debian:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/debian-latest.svg)|Wed Mar 16 14:30:26 UTC 2016| Passed |
|centos:5|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-5.svg)|Wed Mar 16 14:31:03 UTC 2016| Failed |
|centos:6|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-6.svg)|Wed Mar 16 14:32:02 UTC 2016| Passed |
|centos:7|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-7.svg)|Wed Mar 16 14:33:01 UTC 2016| Passed |
|centos:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/centos-latest.svg)|Wed Mar 16 14:34:07 UTC 2016| Passed |
|fedora:21|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-21.svg)|Wed Mar 16 14:35:05 UTC 2016| Passed |
|fedora:22|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-22.svg)|Wed Mar 16 14:36:06 UTC 2016| Passed |
|fedora:23|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-23.svg)|Wed Mar 16 14:37:11 UTC 2016| Passed |
|fedora:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/fedora-latest.svg)|Wed Mar 16 14:38:08 UTC 2016| Passed |
|opensuse:13.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-13.2.svg)|Wed Mar 16 14:39:05 UTC 2016| Passed |
|opensuse:42.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-42.1.svg)|Wed Mar 16 14:39:59 UTC 2016| Passed |
|opensuse:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/opensuse-latest.svg)|Wed Mar 16 14:40:53 UTC 2016| Passed |
|alpine:3.1|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.1.svg)|Wed Mar 16 14:41:43 UTC 2016| Passed |
|alpine:3.2|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.2.svg)|Wed Mar 16 14:42:33 UTC 2016| Passed |
|alpine:3.3|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-3.3.svg)|Wed Mar 16 14:43:24 UTC 2016| Passed |
|alpine:latest|![](https://cdn.rawgit.com/Neilpang/letest/master/status/alpine-latest.svg)|Wed Mar 16 14:44:14 UTC 2016| Passed |
|base/archlinux|![](https://cdn.rawgit.com/Neilpang/letest/master/status/base-archlinux.svg)|Wed Mar 16 15:28:19 UTC 2016| Passed |
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






