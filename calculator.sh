#!/bin/bash

while true; do
	rm \.expr*
	vim expr
	echo "Ans: " "$(echo "scale=4; ""$(cat expr)" | bc)" | less; rm expr
done
