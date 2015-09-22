#!/usr/bin/env bash

set -e

f1=tmp/products_pre
f2=tmp/products

echo -n "Mangling, sorting and writing products to $f1... "
cat data/products.csv |
tail -n+2 |
awk -F ',' '{ printf "%s %s %s ", $(NF-1), $1, $2; for (i=3;i<NF-1;i++){printf "%s", $i}; printf "\n" }' |
sort -r > $f1
# Output is "popularity product_id shop_id name..."
echo "done!"

echo -n "Adding store info... "

# This will take quite a while. Tail `tmp/products` to see progress.
cat data/shops.csv |
tail -n+2 |
awk -F ',' '{ printf "s/ %s / %s %s %s /g\n", $1, $1, $(NF-1), substr($NF, 1, length($NF)-1)}' > tmp/add_shop_info_cmds

cat $f1 | sed -f tmp/add_shop_info_cmds > $f2

# Output is "popularity product_id shop_id lat lng name..."

echo "done!"
