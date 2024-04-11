#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | parallel ./load_denormalized.sh



echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | parallel ./load_normalized.sh



echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time unzip -p test-data.zip | parallel python3 -u load_tweets_batch.py --db postgresql://postgres:pass@localhost:54323 --inputs="$1"
