#!/bin/sh

# Scan for Access Points and use dmenu to pick one line from
# which data can be extracted later
# Usage <script> <interface>

return_to_default() {
	./monitor_mode.sh -d "$INTERFACE"
	#airmon-ng stop "$INTERFACE" 1>/dev/null 2>/dev/null
}


export INTERFACE
INTERFACE="$1"

if [ -z "$1" ]; then
	echo "No interface selected."
	exit 1
fi

trap return_to_default EXIT

# Turn interface to monitor mode, scan for APs
./monitor_mode.sh -e "$INTERFACE"

SCAN_FILE="$(./airo_dump.sh "$INTERFACE")"

sed '' "$SCAN_FILE" | dmenu -l 10 -i -p 'Select AP:'
