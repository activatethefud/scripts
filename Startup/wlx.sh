#!/bin/bash

device=$(nmcli device | grep wlxb0487a93abd0)

if [ ! -z "$device" ]; then
	nmcli device disconnect wlp2s0
fi
