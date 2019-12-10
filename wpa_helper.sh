#!/bin/sh

# Use wpa_supplicant to connect to an Access Point

DNS='172.105.73.239'
ERR_BAD_USAGE=30
ERR_NO_INTERFACE=31
ERR_IF_DOWN=32
ERR_NO_CONFIG=33
CONFIG='/etc/wpa_supplicant.conf'
INTERFACE='wlan1'

kill_check() {
		pkill -9 wpa_supplicant
		#pkill -9 dhclient
}

if [ -n "$2" ]
then

# Kill running processes before proceeding
kill_check

SSID="$1"
PASS="$2"

# Interface exists check
if ! iw dev | grep -q "$INTERFACE"
then
	printf "Interface ["$INTERFACE"] doesn't exist!\\n" 1>&2
	exit $ERR_NO_INTERFACE
fi


ip link set "$INTERFACE" up || exit "$ERR_IF_DOWN"
wpa_passphrase "$SSID" "$PASS" 1 > "$CONFIG"
wpa_supplicant -i "$INTERFACE" -c "$CONFIG" -B
echo "$DNS" > /etc/resolv.conf

# Renewew DHCP leases
dhclient -r

# Start dhclient to get an IP address
dhclient
	
echo "nameserver $DNS" > /etc/resolv.conf

fi

# No arguments entered case
if [ -z "$1" ]
then

# Reuse latest configuration
if [ -f "$CONFIG" ]
then
	kill_check
	ip link set "$INTERFACE" up || exit "$ERR_IF_DOWN"
	wpa_supplicant -i "$INTERFACE" -c "$CONFIG" -B

	dhclient -r
	dhclient
	
	echo "nameserver $DNS" > /etc/resolv.conf

else
	
	# No config found, no arguments => Error
	printf "No configuration file found!\\n" 1>&2
	exit $ERR_NO_CONFIG
fi

else
	printf "Bad usage!\\nUsage: <script> [SSID] [PASS]\\n" 1>&2
	exit $ERR_NO_CONFIG
fi
