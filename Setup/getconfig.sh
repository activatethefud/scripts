#!/bin/bash


#tail -n +154 ~/.config/i3/config > ./config/i3config
tail -n +119 ~/.bashrc > ./config/bashconfig
sudo tail -n +26 /var/spool/cron/crontabs/$(whoami) > ./config/cronconfig

cf=files

for file in $(cat $cf | sed "s/~/\/home\/$(whoami)/" ); do
	cp $file ./config
done
