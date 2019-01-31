#!/bin/bash

cd /home/nikola/Documents/Scripts/matf_notifications/Programiranje1

python3 scrape.py > log2

linesdiff=$(diff log1 log2 | wc -l)

if [ $linesdiff -ge 1 ]; then
	diff log1 log2 | grep ">" | awk {'$1="";print'} | mail -s "Programiranje 1 obavestenje" nikolasutic1@gmail.com
	cat log2>log1
fi
