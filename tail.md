
# How to run tests

As simple as just run a script:

```
./letest.sh
```

It will use cloudflare tunnel to test on your local machine.


You can also test with your own domain, first point at least 2 of your domains to your machine, 
for example: `example.com` and `www.example.com`

And make sure 80 port is not used by anyone else.

```
cd acmetest
TestingDomain=example.com   TestingAltDomains=www.example.com  ./letest.sh
```

If you are not root,  please use `sudo`, because the script will have to listen at `80` port:

```
cd acmetest
sudo  TestingDomain=example.com   TestingAltDomains=www.example.com  ./letest.sh

```

# How to run tests in all the platforms through docker.

You must have docker installed, and also point 2 of your domains to your machine.

Then test all the platforms :

```
cd acmetest
./rundocker.sh  testall
```

It will use cloudflare tunnel test.

Or use your own domain:

```
cd acmetest
TestingDomain=example.com   TestingAltDomains=www.example.com  ./rundocker.sh  testall
```

The script will download all the supported platforms from the official docker hub, then run the test cases in all the supported platforms.

Then test single docker platform :

```
cd acmetest
./rundocker.sh  testall
```

Or:

```
cd acmetest
TestingDomain=example.com   TestingAltDomains=www.example.com  ./rundocker.sh  testplat   ubuntu:latest
```




