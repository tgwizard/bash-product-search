#!/usr/bin/env bash

set -e

json=$(awk '{title=$9; for(i=10;i<=NF;i++){title=title " " $i}; gsub(/^"|"$/, "", title); printf "{\"title\": \"%s\", \"popularity\": \"%s\", \"shop\": {\"id\": \"%s\", \"lat\": %f, \"lng\": %f}},\n", title, $4, $6, $7, $8 }')
echo $json | sed 's/,$//g'
