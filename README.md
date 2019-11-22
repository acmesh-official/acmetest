# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://neilpang.github.io/acmetest/status/freebsd.svg?1574388358)| Fri, 22 Nov 2019 02:05:58 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://neilpang.github.io/acmetest/status/openbsd.svg?1574388949)| Fri, 22 Nov 2019 02:15:49 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://neilpang.github.io/acmetest/status/pfsense.svg?1574389435)| Fri, 22 Nov 2019 02:23:55 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://neilpang.github.io/acmetest/status/solaris.svg?1574390008)| Fri, 22 Nov 2019 02:33:28 GMT| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://neilpang.github.io/acmetest/status/windows-cygwin.svg?1574391280)| Fri, 22 Nov 2019 02:54:40 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://neilpang.github.io/acmetest/status/ubuntu-latest.svg?1574391718)| Fri, 22 Nov 2019 03:01:58 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:18.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-18.04.svg?1574392572)| Fri, 22 Nov 2019 03:16:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-18.04.out) |
|ubuntu:16.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-16.04.svg?1574393440)| Fri, 22 Nov 2019 03:30:40 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-14.04.svg?1574393839)| Fri, 22 Nov 2019 03:37:19 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://neilpang.github.io/acmetest/status/debian-latest.svg?1574394708)| Fri, 22 Nov 2019 03:51:48 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:10| ![](https://neilpang.github.io/acmetest/status/debian-10.svg?1574395564)| Fri, 22 Nov 2019 04:06:04 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-10.out) |
|debian:9| ![](https://neilpang.github.io/acmetest/status/debian-9.svg?1574396400)| Fri, 22 Nov 2019 04:20:00 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://neilpang.github.io/acmetest/status/debian-8.svg?1574396871)| Fri, 22 Nov 2019 04:27:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://neilpang.github.io/acmetest/status/debian-7.svg?1574397323)| Fri, 22 Nov 2019 04:35:23 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://neilpang.github.io/acmetest/status/centos-latest.svg?1574397740)| Fri, 22 Nov 2019 04:42:20 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://neilpang.github.io/acmetest/status/centos-7.svg?1574398209)| Fri, 22 Nov 2019 04:50:09 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |
|centos:6| ![](https://neilpang.github.io/acmetest/status/centos-6.svg?1574398685)| Fri, 22 Nov 2019 04:58:05 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-6.out) |
|fedora:latest| ![](https://neilpang.github.io/acmetest/status/fedora-latest.svg?1574399138)| Fri, 22 Nov 2019 05:05:38 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-latest.out) |

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








