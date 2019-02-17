#!/bin/bash

cd "$(dirname "$0")"

extract() {
	if [ ! -d images ]; then
		mkdir images
	else
		rm -r images
		mkdir images
	fi
	grep -P -o "href=\".*?\"" thread | grep -P -o "\".*\.png\"" | sed "s/\"//g; s/\/\///" | uniq  > ./images/urls
	cd images
	wget -U mozilla -nc -e robots=off --input-file=urls
}

html() {
	wget -U mozilla -e robots=off --output-document=thread $1
}

html $@
extract

