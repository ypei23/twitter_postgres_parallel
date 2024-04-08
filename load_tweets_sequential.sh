#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
for file in $files; do
	unzip -p test-data.zip | sed 's/\\u0000//g' | psql "postgresql://postgres:pass@localhost:1352" -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done


echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
for file in $files; do
	python3 -u load_tweets.py --db postgresql://postgres:pass@localhost:2351 --inputs $file
done


echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:3/ --inputs $file
done
