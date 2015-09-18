#!/usr/bin/env bash

set -e

path=

count=10
radius=500
lat=0
lng=0

function parse_http_request {
  # an http (v 1.1) request looks like this:
  #
  #  METHOD /path HTTP/1.1
  #  Header: value
  #  Other-heder: value
  #  Cookie: here-comes-the-cookies
  #
  #  request body
  #
  # the headers are separated from the body by an empty line
  # we are interested in the method and the path (mostly the path)
  read method path version

  # /search?count=10&radius=500&lat=59.33258&lng=18.0649&tags=
  count_re=".*count=([0-9]+).*"
  if [[ "$path" =~ $count_re ]]; then
    count=${BASH_REMATCH[1]}
  fi

  radius_re=".*radius=([0-9]+).*"
  if [[ "$path" =~ $radius_re ]]; then
    radius=${BASH_REMATCH[1]}
  fi

  lat_re=".*lat=([0-9.]+).*"
  if [[ "$path" =~ $lat_re ]]; then
    lat=${BASH_REMATCH[1]}
  fi

  lng_re=".*lng=([0-9.]+).*"
  if [[ "$path" =~ $lng_re ]]; then
    lng=${BASH_REMATCH[1]}
  fi
}

function find_products {
  products=$(./find_products.sh $lat $lng $radius $count 2>/dev/null | ./build_json.sh 2>/dev/null)
}


function render_response {
  echo "HTTP/1.1 200 OK
Content-Type: application/json
Access-Control-Allow-Origin: *
Connection: close

{
  \"products\": [
    $products
  ]
}"

}

parse_http_request
find_products
render_response

exit 0
