#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
for file in $files; do
	echo 
	unzip -p "$file" | sed 's/\\u0000//g' | psql "postgresql://postgres:pass@localhost:1352" -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done



echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
for file in $files; do
	python3 -u load_tweets.py --db postgresql://postgres:pass@localhost:2351 --inputs $file
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
