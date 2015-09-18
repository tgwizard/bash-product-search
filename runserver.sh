#!/usr/bin/env bash

set -e

echo "Listening on http://localhost:5000/search"

while true ; do netcat -l -p 5000 -e ./server.sh; test $? -gt 128 && break ; done
