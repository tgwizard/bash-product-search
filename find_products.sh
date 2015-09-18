#!/usr/bin/env bash

set -e

lat=$1
lng=$2
radius=$3
limit=$4

cat tmp/products |
awk -F ',' -v lat=$lat -v lng=$lng '{ print lat, lng, $0}' |
awk -f haversine |
awk -v radius=$radius '{ if ($1 <= radius) print $0 }' |
head -n $limit

# Will output according to format:
# distance input_lat input_lng popularity product_id store_id store_lat store_lng product_name
# Ex:
# 397.393608 59.33258 18.0649 1.000 e3142db1a976471891257228ac532000 2f8aab36b8884969811519d1fd0ac1c4 59.335460084597436 18.060754569857444 Annie
