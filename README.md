# acmetest
Unit test project for **acme.sh** project https://github.com/acmesh-official/acme.sh



# Here are the latest status:

| Platform | Status| Last Run Time| Comments|
-----------|-------|--------------|---------|
|freebsd| ![](https://acmesh-official.github.io/acmetest/status/freebsd.svg?1583132561)| Mon, 02 Mar 2020 07:02:41 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/freebsd.out) |
|openbsd| ![](https://acmesh-official.github.io/acmetest/status/openbsd.svg?1583161671)| Mon, 02 Mar 2020 15:07:51 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/openbsd.out) |
|pfsense| ![](https://acmesh-official.github.io/acmetest/status/pfsense.svg?1583161955)| Mon, 02 Mar 2020 15:12:35 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/pfsense.out) |
|solaris| ![](https://acmesh-official.github.io/acmetest/status/solaris.svg?1583162264)| Mon, 02 Mar 2020 15:17:44 GMT| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/solaris.out) |
|windows-cygwin| ![](https://acmesh-official.github.io/acmetest/status/windows-cygwin.svg?1583205823)| Tue, 03 Mar 2020 03:23:43 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/windows-cygwin.out) |
|ubuntu:latest| ![](https://acmesh-official.github.io/acmetest/status/ubuntu-latest.svg?1583240766)| Tue, 03 Mar 2020 13:06:06 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/ubuntu-latest.out) |
|debian:latest| ![](https://acmesh-official.github.io/acmetest/status/debian-latest.svg?1583240959)| Tue, 03 Mar 2020 13:09:19 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/debian-latest.out) |
|centos:latest| ![](https://acmesh-official.github.io/acmetest/status/centos-latest.svg?1583241171)| Tue, 03 Mar 2020 13:12:51 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/centos-latest.out) |
|fedora:latest| ![](https://acmesh-official.github.io/acmetest/status/fedora-latest.svg?1583241378)| Tue, 03 Mar 2020 13:16:18 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/fedora-latest.out) |
|opensuse:latest| ![](https://acmesh-official.github.io/acmetest/status/opensuse-latest.svg?1583243488)| Tue, 03 Mar 2020 13:51:28 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/opensuse-latest.out) |
|alpine:latest| ![](https://acmesh-official.github.io/acmetest/status/alpine-latest.svg?1583243807)| Tue, 03 Mar 2020 13:56:47 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/alpine-latest.out) |
|oraclelinux:latest| ![](https://acmesh-official.github.io/acmetest/status/oraclelinux-latest.svg?1583241905)| Tue, 03 Mar 2020 13:25:05 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/oraclelinux-latest.out) |
|kalilinux/kali-linux-docker| ![](https://acmesh-official.github.io/acmetest/status/kalilinux-kali-linux-docker.svg?1583243819)| Tue, 03 Mar 2020 13:56:59 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/kalilinux-kali-linux-docker.out) |
|base/archlinux| ![](https://acmesh-official.github.io/acmetest/status/base-archlinux.svg?1583243830)| Tue, 03 Mar 2020 13:57:10 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/base-archlinux.out) |
|mageia| ![](https://acmesh-official.github.io/acmetest/status/mageia.svg?1583242118)| Tue, 03 Mar 2020 13:28:38 UTC| [Passed](https://github.com/acmesh-official/acmetest/blob/master/logs/mageia.out) |
|gentoo/stage3-amd64| ![](https://acmesh-official.github.io/acmetest/status/gentoo-stage3-amd64.svg?1583244611)| Tue, 03 Mar 2020 14:10:11 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/gentoo-stage3-amd64.out) |
|clearlinux:latest| ![](https://acmesh-official.github.io/acmetest/status/clearlinux-latest.svg?1583243475)| Tue, 03 Mar 2020 13:51:15 UTC| [Failed](https://github.com/acmesh-official/acmetest/blob/master/logs/clearlinux-latest.out) |

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








