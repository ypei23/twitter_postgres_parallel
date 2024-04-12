#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | time parallel ./load_denormalized.sh



echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | time parallel ./load_normalized.sh



echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time echo "$files" | time parallel ./load_normalized_batch.sh 
