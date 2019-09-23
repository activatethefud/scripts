#!/bin/sh

# Use wpa_supplicant to connect to an Access Point

ERR_BAD_USAGE=30
ERR_NO_INTERFACE=31
ERR_IF_DOWN=32

if [ -z "$2" ]
then
	printf "Bad usage!\\nUsage: <script> <SSID> <PASS>\\n" 1>&2
	exit $ERR_BAD_USAGE
fi

kill_check() {
		pkill -9 wpa_supplicant
		#pkill -9 dhclient
}

# Kill running processes before proceeding
kill_check

SSID="$1"
PASS="$2"
INTERFACE='wlan1'

# Interface exists check
if ! iw dev | grep -q "$INTERFACE"
then
	printf "Interface ["$INTERFACE"] doesn't exist!\\n" 1>&2
	exit $ERR_NO_INTERFACE
fi

CONFIG='/etc/wpa_supplicant.conf'

ip link set "$INTERFACE" up || exit "$ERR_IF_DOWN"
wpa_passphrase "$SSID" "$PASS" > "$CONFIG"
wpa_supplicant -i "$INTERFACE" -c "$CONFIG" -B

# Renewew DHCP leases
dhclient -r

# Start dhclient to get an IP address
dhclient
