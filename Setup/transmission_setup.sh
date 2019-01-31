#!/bin/bash

os=$(uname -n)

if [[ $os == *buntu ]]; then
	install="sudo apt-get install"
fi

$install vim

if [ $(dpkg --get-selection | grep transmission-daemon | wc -l) -eq 0 ]; then
	$install transmission-daemon
fi

if [ $(dpkg --get-selection | grep transmission-remote-cli | wc -l) -eq 0 ]; then
	$install transmission-remote-cli
fi

if [[ $os = *buntu ]]; then
	sudo service transmission-daemon stop
	if [ ! -d /home/$(whoami)/Downloads/Torrents ]; then
		mkdir /home/$(whoami)/Downloads/Torrents
	fi
	sudo sed -i "s/"download-dir":\s".*"/"download-dir": "\/home\/$\(whoami\)\/Downloads\/Torrents"/g" /etc/transmission-daemon/settings.json
	sudo sed -i "/ratio-limit\"/s/[0-9][0-9]*/0/" /etc/transmission-daemon/settings.json
	sudo service transmission-daemon start
fi

cd /home/$(whoami)
echo "alias tsel='transmission-remote --auth transmission:transmission -t '" >> ~/.bashrc
echo "alias tadd='transmission-remote --auth transmission:transmission -a '" >> ~/.bashrc
echo "alias tlist='transmission-remote --auth transmission:transmission -l'" >> ~/.bashrc
echo "alias twatch='watch --interval 0.5 transmission-remote --auth transmission:transmission -l'" >> ~/.bashrc

	
