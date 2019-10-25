# acmetest
Unit test project for **acme.sh** project https://github.com/Neilpang/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://neilpang.github.io/acmetest/status/freebsd.svg?1571966769)| Fri, 25 Oct 2019 01:26:09 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://neilpang.github.io/acmetest/status/openbsd.svg?1571968579)| Fri, 25 Oct 2019 01:56:19 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://neilpang.github.io/acmetest/status/pfsense.svg?1571970247)| Fri, 25 Oct 2019 02:24:07 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://neilpang.github.io/acmetest/status/solaris.svg?1571970792)| Fri, 25 Oct 2019 02:33:12 GMT| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://neilpang.github.io/acmetest/status/windows-cygwin.svg?1571973239)| Fri, 25 Oct 2019 03:13:59 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://neilpang.github.io/acmetest/status/ubuntu-latest.svg?1571976492)| Fri, 25 Oct 2019 04:08:12 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-latest.out) |
|ubuntu:18.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-18.04.svg?1571979752)| Fri, 25 Oct 2019 05:02:32 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-18.04.out) |
|ubuntu:16.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-16.04.svg?1571983015)| Fri, 25 Oct 2019 05:56:55 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-16.04.out) |
|ubuntu:14.04| ![](https://neilpang.github.io/acmetest/status/ubuntu-14.04.svg?1571986261)| Fri, 25 Oct 2019 06:51:01 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/ubuntu-14.04.out) |
|debian:latest| ![](https://neilpang.github.io/acmetest/status/debian-latest.svg?1571989499)| Fri, 25 Oct 2019 07:44:59 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-latest.out) |
|debian:10| ![](https://neilpang.github.io/acmetest/status/debian-10.svg?1571992709)| Fri, 25 Oct 2019 08:38:29 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-10.out) |
|debian:9| ![](https://neilpang.github.io/acmetest/status/debian-9.svg?1571994347)| Fri, 25 Oct 2019 09:05:47 UTC| [Failed](https://github.com/Neilpang/acmetest/blob/master/logs/debian-9.out) |

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








