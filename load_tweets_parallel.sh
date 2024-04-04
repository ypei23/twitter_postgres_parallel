#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
#time for file in $files; do
#    ./load_denormalized.sh "$file"
    #unzip -p "$file" | sed 's/\\u0000//g' | psql postgresql://postgres:pass@localhost:15433/ -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
#done
time echo "$files" | parallel ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
