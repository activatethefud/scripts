#!/bin/bash

for file in ./config/*; do
	#cp $file $( grep $file files )
	echo $( grep "$(echo $file | sed "s/.\///g")" files)
done



#desi torima
#kad god ne ide
#ti raspremi krevet

