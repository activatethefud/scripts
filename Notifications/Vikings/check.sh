#!/bin/bash

cd "$(dirname "$0")"

if [ $(python3 latest.py) -eq 0 ]; then
	echo "Episode $(cat latest.txt) is out!" | mail -s "Vikings: New episode" nikolasutic1@gmail.com
fi

