#!/bin/bash

cd /home/nikola/Documents/Scripts/matf_notifications/Racunari1


python3 scrape.py > log2
difference=$(diff log1 log2 | wc -l)

if [ $difference -ge 1 ]; then
	diff log1 log2 | grep ">" | awk {'$1="";print'} | mail -s "UOAR 1 obavestenje" nikolasutic1@gmail.com
	cat log2 > log1
fi
