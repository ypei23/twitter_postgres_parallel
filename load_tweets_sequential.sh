#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
	echo
	unzip -p "$file" | sed 's/\\u0000//g' | psql "postgresql://postgres:pass@localhost:54321" -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done


echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
	python3 -u load_tweets.py --db postgresql://postgres:pass@localhost:54322 --inputs $file
done


echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:54323/ --inputs $file
done
