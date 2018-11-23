# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1542906313)| Thu, 22 Nov 2018 17:05:13 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1542935471)| Fri, 23 Nov 2018 01:11:11 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?1542935768)| Fri, 23 Nov 2018 01:16:08 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?1542936111)| Fri, 23 Nov 2018 01:21:51 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1542936888)| Fri, 23 Nov 2018 01:34:48 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?1542937129)| Fri, 23 Nov 2018 01:38:49 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:17.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-17.04.svg?1542937147)| Fri, 23 Nov 2018 01:39:07 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-17.04.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?1542937396)| Fri, 23 Nov 2018 01:43:16 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?1542937606)| Fri, 23 Nov 2018 01:46:46 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-latest.svg?1542937826)| Fri, 23 Nov 2018 01:50:26 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:9| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-9.svg?1542938055)| Fri, 23 Nov 2018 01:54:15 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?1542938271)| Fri, 23 Nov 2018 01:57:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?1542938482)| Fri, 23 Nov 2018 02:01:22 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-latest.svg?1542938733)| Fri, 23 Nov 2018 02:05:33 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-7.svg?1542938981)| Fri, 23 Nov 2018 02:09:41 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-6.svg?1542938997)| Fri, 23 Nov 2018 02:09:57 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-6.out) |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-latest.svg?1542939235)| Fri, 23 Nov 2018 02:13:55 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-latest.out) |
|fedora:27| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-27.svg?1542939468)| Fri, 23 Nov 2018 02:17:48 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-27.out) |
|fedora:26| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-26.svg?1542939707)| Fri, 23 Nov 2018 02:21:47 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-26.out) |
|fedora:25| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-25.svg?1542939933)| Fri, 23 Nov 2018 02:25:33 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-25.out) |

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








