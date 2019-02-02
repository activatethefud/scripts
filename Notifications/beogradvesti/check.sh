#!/bin/bash

cd "$(dirname "$0")"

link="https://www.srbijadanas.com/vesti/beograd"
message="Beograd vesti"

if [ ! -f old ]; then
	wget --output-document=old -e robots=off -U mozilla "$link"
fi

#wget --output-document=new -e robots=off -U mozilla "$link"
#
#if [ $(cat new | wc -l) -ne 0 ]; then
#	if [ $(diff old new | wc -l) -gt 4 ]; then
#		echo "$(diff old new | grep "<a")" | mail -s "$message" nikolasutic1@gmail.com
#	fi
#fi



