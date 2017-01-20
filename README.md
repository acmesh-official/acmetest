# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?Fri, 20 Jan 2017 11:06:08 UTC)| Fri, 20 Jan 2017 11:06:08 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?Fri, 20 Jan 2017 11:14:09 UTC)| Fri, 20 Jan 2017 11:14:09 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?Fri, 20 Jan 2017 11:19:40 UTC)| Fri, 20 Jan 2017 11:19:40 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?Fri, 20 Jan 2017 11:27:13 GMT)| Fri, 20 Jan 2017 11:27:13 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?Fri, 20 Jan 2017 11:47:14 UTC)| Fri, 20 Jan 2017 11:47:14 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?Fri, 20 Jan 2017 11:51:36 UTC)| Fri, 20 Jan 2017 11:51:36 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-15.04.svg?Fri, 20 Jan 2017 11:55:55 UTC)| Fri, 20 Jan 2017 11:55:55 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-15.04.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?Fri, 20 Jan 2017 12:00:43 UTC)| Fri, 20 Jan 2017 12:00:43 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?Fri, 20 Jan 2017 12:05:35 UTC)| Fri, 20 Jan 2017 12:05:35 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?Fri, 20 Jan 2017 12:14:05 UTC)| Fri, 20 Jan 2017 12:14:05 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?Fri, 20 Jan 2017 12:18:21 UTC)| Fri, 20 Jan 2017 12:18:21 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-latest.svg?Fri, 20 Jan 2017 12:22:41 UTC)| Fri, 20 Jan 2017 12:22:41 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|centos:5| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-5.svg?Fri, 20 Jan 2017 12:25:53 UTC)| Fri, 20 Jan 2017 12:25:53 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-5.out) |

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








