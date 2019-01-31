#!/bin/bash
os=$(uname -n)

if [[ $os == *buntu ]]; then
	install="sudo apt-get install"
	update="sudo apt-get update"
fi

$update

$install $(cat packages)
