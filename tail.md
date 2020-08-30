
# How to run tests

First point at least 2 of your domains to your machine, 
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
TestingDomain=example.com   TestingAltDomains=www.example.com  ./rundocker.sh  testall
```

The script will download all the supported platforms from the official docker hub, then run the test cases in all the supported platforms.

Then test single docker platform :

```
cd acmetest
TestingDomain=example.com   TestingAltDomains=www.example.com  ./rundocker.sh  testplat   centos:latest
```

# Run tests with ngrok automatically

If you don't want to use 2 domains to test, we can use ngrok to test with temp domain.

Please register an free account at https://ngrok.com/

You will get your ngrok auth token.  Then:

```
export NGROK_TOKEN="xxxxxxxxxx"

./letest.sh

```

If you are not root,  please use `sudo`, because the script will have to listen at `80` port:

```
export NGROK_TOKEN="xxxxxxxxxx"

sudo  --preserve-env  ./letest.sh
```







