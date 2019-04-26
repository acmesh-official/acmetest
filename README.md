# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://neilpang.github.io/acmetest/status/freebsd.svg?1556240719)| Fri, 26 Apr 2019 01:05:19 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://neilpang.github.io/acmetest/status/openbsd.svg?1556241354)| Fri, 26 Apr 2019 01:15:54 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://neilpang.github.io/acmetest/status/pfsense.svg?1556241819)| Fri, 26 Apr 2019 01:23:39 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://neilpang.github.io/acmetest/status/solaris.svg?1556242354)| Fri, 26 Apr 2019 01:32:34 GMT| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://neilpang.github.io/acmetest/status/windows-cygwin.svg?1556243572)| Fri, 26 Apr 2019 01:52:52 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://neilpang.github.io/acmetest/status/ubuntu-latest.svg?1556244029)| Fri, 26 Apr 2019 02:00:29 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:16.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-16.04.svg?1556244459)| Fri, 26 Apr 2019 02:07:39 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-14.04.svg?1556244906)| Fri, 26 Apr 2019 02:15:06 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://neilpang.github.io/acmetest/status/debian-latest.svg?1556245328)| Fri, 26 Apr 2019 02:22:08 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:9| ![](https://neilpang.github.io/acmetest/status/debian-9.svg?1556245761)| Fri, 26 Apr 2019 02:29:21 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://neilpang.github.io/acmetest/status/debian-8.svg?1556246214)| Fri, 26 Apr 2019 02:36:54 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://neilpang.github.io/acmetest/status/debian-7.svg?1556246652)| Fri, 26 Apr 2019 02:44:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://neilpang.github.io/acmetest/status/centos-latest.svg?1556247108)| Fri, 26 Apr 2019 02:51:48 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://neilpang.github.io/acmetest/status/centos-7.svg?1556247573)| Fri, 26 Apr 2019 02:59:33 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |
|centos:6| ![](https://neilpang.github.io/acmetest/status/centos-6.svg?1556248026)| Fri, 26 Apr 2019 03:07:06 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-6.out) |
|fedora:latest| ![](https://neilpang.github.io/acmetest/status/fedora-latest.svg?1556248517)| Fri, 26 Apr 2019 03:15:17 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-latest.out) |
|fedora:27| ![](https://neilpang.github.io/acmetest/status/fedora-27.svg?1556249407)| Fri, 26 Apr 2019 03:30:07 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-27.out) |
|fedora:26| ![](https://neilpang.github.io/acmetest/status/fedora-26.svg?1556249825)| Fri, 26 Apr 2019 03:37:05 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-26.out) |
|fedora:25| ![](https://neilpang.github.io/acmetest/status/fedora-25.svg?1556250249)| Fri, 26 Apr 2019 03:44:09 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-25.out) |
|fedora:24| ![](https://neilpang.github.io/acmetest/status/fedora-24.svg?1556250709)| Fri, 26 Apr 2019 03:51:49 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-24.out) |
|fedora:23| ![](https://neilpang.github.io/acmetest/status/fedora-23.svg?1556251147)| Fri, 26 Apr 2019 03:59:07 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-23.out) |

# How to run tests

First point at least 2 of your domains to your machine, 
for example: `aa.com` and `www.aa.com`

And make sure 80 port is not used by anyone else.

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./letest.sh
```

# How to run tests in all the platforms through docker.

You must have docker installed, and also point 2 of your domains to your machine.

Then test all the platforms :

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./rundocker.sh  testall
```

The script will download all the supported platforms from the official docker hub, then run the test cases in all the supported platforms.

Then test single docker platform :

```
cd acmetest
TestingDomain=aa.com   TestingAltDomains=www.aa.com  ./rundocker.sh  testplat   centos:latest
```

# Run tests with ngrok automatically

If you don't want to use 2 domains to test, we can use ngrok to test with temp domain.

Please register an free account at https://ngrok.com/

You will get your ngrok auth token.  Then:

```
export NGROK_TOKEN="xxxxxxxxxx"

./letest.sh

```








