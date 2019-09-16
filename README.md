# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://neilpang.github.io/acmetest/status/freebsd.svg?1568355988)| Fri, 13 Sep 2019 06:26:28 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://neilpang.github.io/acmetest/status/openbsd.svg?1568356586)| Fri, 13 Sep 2019 06:36:26 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://neilpang.github.io/acmetest/status/pfsense.svg?1568375642)| Fri, 13 Sep 2019 11:54:02 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://neilpang.github.io/acmetest/status/solaris.svg?1568394771)| Fri, 13 Sep 2019 17:12:51 GMT| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://neilpang.github.io/acmetest/status/windows-cygwin.svg?1568396158)| Fri, 13 Sep 2019 17:35:58 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://neilpang.github.io/acmetest/status/ubuntu-latest.svg?1568434216)| Sat, 14 Sep 2019 04:10:16 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:16.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-16.04.svg?1568453864)| Sat, 14 Sep 2019 09:37:44 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-14.04.svg?1568473475)| Sat, 14 Sep 2019 15:04:35 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://neilpang.github.io/acmetest/status/debian-latest.svg?1568493125)| Sat, 14 Sep 2019 20:32:05 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:9| ![](https://neilpang.github.io/acmetest/status/debian-9.svg?1568493944)| Sat, 14 Sep 2019 20:45:44 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://neilpang.github.io/acmetest/status/debian-8.svg?1568513552)| Sun, 15 Sep 2019 02:12:32 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://neilpang.github.io/acmetest/status/debian-7.svg?1568533169)| Sun, 15 Sep 2019 07:39:29 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://neilpang.github.io/acmetest/status/centos-latest.svg?1568552801)| Sun, 15 Sep 2019 13:06:41 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://neilpang.github.io/acmetest/status/centos-7.svg?1568591450)| Sun, 15 Sep 2019 23:50:50 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |
|centos:6| ![](https://neilpang.github.io/acmetest/status/centos-6.svg?1568611512)| Mon, 16 Sep 2019 05:25:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-6.out) |
|fedora:latest| ![](https://neilpang.github.io/acmetest/status/fedora-latest.svg?1568631234)| Mon, 16 Sep 2019 10:53:55 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-latest.out) |
|fedora:27| ![](https://neilpang.github.io/acmetest/status/fedora-27.svg?1568631668)| Mon, 16 Sep 2019 11:01:08 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-27.out) |
|fedora:26| ![](https://neilpang.github.io/acmetest/status/fedora-26.svg?1568632139)| Mon, 16 Sep 2019 11:08:59 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-26.out) |

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








