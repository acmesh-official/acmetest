# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1495764523)| Fri, 26 May 2017 02:08:43 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1495765177)| Fri, 26 May 2017 02:19:37 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?1495765690)| Fri, 26 May 2017 02:28:10 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?1495765082)| Fri, 26 May 2017 02:18:02 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1495766603)| Fri, 26 May 2017 02:43:23 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?1495767042)| Fri, 26 May 2017 02:50:42 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-15.04.svg?1495767466)| Fri, 26 May 2017 02:57:46 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-15.04.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?1495767922)| Fri, 26 May 2017 03:05:22 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:17.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-17.04.svg?1495768813)| Fri, 26 May 2017 03:20:13 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-17.04.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?1495769271)| Fri, 26 May 2017 03:27:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?1495769691)| Fri, 26 May 2017 03:34:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?1495770119)| Fri, 26 May 2017 03:41:59 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |

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








