# Product geo search, in BASH

This is a proof-of-concept app, where a client (JS) can search products by geo location (lat + lang), specify radius to search in, and how many products to return.

The backend is written as BASH scripts.

# Local setup

## Prerequisites

A modern version of netcat is required to run this.
The one preinstalled on Mac OS X is not good enough.

```
brew install netcat
```

## Preprocess data

This will take quite a while. Tail `tmp/products` to see progress.

```
./pre_build_products.sh
```


## Run

The server

```
./runserver.sh
```

The client:

```
cd client
python -m SimpleHTTPServer
```


## Commandline test runs:

```
./find_products.sh 59.33258 18.0649 500 10 | ./build_json.sh
