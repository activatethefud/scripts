#!/bin/bash

cd /home/nikola/Documents/Scripts/matf_notifications/LAAG


python3 scrape.py > log2

lineschanged=$(diff log1 log2 | wc -l)

if [ $lineschanged -ge 1 ]; then
	diff log1 log2 | grep ">" | awk {'$1="";print'} | mail -s "LAAG obavestenje" nikolasutic1@gmail.com
	cat log2 > log1
fi
