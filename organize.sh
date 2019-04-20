#!/bin/bash

newdir() {
	if [ ! -d "$1" ]; then
		mkdir "$1"
	fi
}

