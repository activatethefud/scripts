#!/bin/bash

cd "$(dirname "$0")"
link="http://poincare.matf.bg.ac.rs/~biljana/uoarh1_vesti.html"
message="UOR Promena"

if [ ! -f old.txt ];then
	wget --output-document=old -e robots=off -U mozilla "$link"
fi

wget --output-document=new -e robots=off -U mozilla "$link"


if [ ! -z "$(cat new)" ]; then
	if [ $(diff old new | wc -l) -ne 0 ]; then
		mail -s "$message" nikolasutic1@gmail.com
	fi
fi






 
