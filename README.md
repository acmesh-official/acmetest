# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/freebsd.svg?1547143373)| Thu, 10 Jan 2019 18:02:53 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/openbsd.svg?1547172532)| Fri, 11 Jan 2019 02:08:52 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/pfsense.svg?1547172874)| Fri, 11 Jan 2019 02:14:34 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/solaris.svg?1547173219)| Fri, 11 Jan 2019 02:20:19 GMT| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/windows-cygwin.svg?1547174030)| Fri, 11 Jan 2019 02:33:51 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-latest.svg?1547174277)| Fri, 11 Jan 2019 02:37:57 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:16.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-16.04.svg?1547174514)| Fri, 11 Jan 2019 02:41:54 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/ubuntu-14.04.svg?1547174745)| Fri, 11 Jan 2019 02:45:45 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-latest.svg?1547174964)| Fri, 11 Jan 2019 02:49:24 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:9| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-9.svg?1547175178)| Fri, 11 Jan 2019 02:52:58 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |
|debian:8| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-8.svg?1547175393)| Fri, 11 Jan 2019 02:56:33 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-8.out) |
|debian:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/debian-7.svg?1547175604)| Fri, 11 Jan 2019 03:00:04 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-7.out) |
|centos:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-latest.svg?1547175855)| Fri, 11 Jan 2019 03:04:15 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-latest.out) |
|centos:7| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-7.svg?1547176099)| Fri, 11 Jan 2019 03:08:19 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-7.out) |
|centos:6| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/centos-6.svg?1547176114)| Fri, 11 Jan 2019 03:08:34 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/centos-6.out) |
|fedora:latest| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-latest.svg?1547176379)| Fri, 11 Jan 2019 03:12:59 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-latest.out) |
|fedora:27| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-27.svg?1547176895)| Fri, 11 Jan 2019 03:21:35 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-27.out) |
|fedora:26| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-26.svg?1547177136)| Fri, 11 Jan 2019 03:25:36 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-26.out) |
|fedora:25| ![](https://cdn.rawgit.com/Neilpang/acmetest/master/status/fedora-25.svg?1547177356)| Fri, 11 Jan 2019 03:29:16 UTC| [Passed](https://github.com/Neilpang/acmetest/blob/master/logs/fedora-25.out) |

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








