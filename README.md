# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1497624894)| Fri, 16 Jun 2017 14:54:54 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1497625632)| Fri, 16 Jun 2017 15:07:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?1497626225)| Fri, 16 Jun 2017 15:17:05 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?1497626882)| Fri, 16 Jun 2017 15:28:02 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1497627887)| Fri, 16 Jun 2017 15:44:47 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?1497628467)| Fri, 16 Jun 2017 15:54:27 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:17.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-17.04.svg?1497629052)| Fri, 16 Jun 2017 16:04:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-17.04.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?1497629631)| Fri, 16 Jun 2017 16:13:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:15.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-15.04.svg?1497630180)| Fri, 16 Jun 2017 16:23:00 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-15.04.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?1497630728)| Fri, 16 Jun 2017 16:32:08 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-latest.svg?1497631264)| Fri, 16 Jun 2017 16:41:04 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?1497631812)| Fri, 16 Jun 2017 16:50:12 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?1497632889)| Fri, 16 Jun 2017 17:08:09 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-latest.svg?1497633444)| Fri, 16 Jun 2017 17:17:24 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-7.svg?1497634009)| Fri, 16 Jun 2017 17:26:49 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |

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








