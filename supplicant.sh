#!/bin/sh

# This script connects to the Access Point
# Usage <script> <interface> <option_new> <essid_new> <pass_new>

CONFIG_FILE="/etc/wpa_supplicant.conf"

killnet() {
	killall wpa_supplicant dhclient 2>/dev/null &&
	return 0
}

case "$2" in
# Create new config file when first connecting to a new Access Point
  "-n") wpa_passphrase "$3" "$4" > "$CONFIG_FILE"
  	;;
# Get current configuration
  "-c") cat "$CONFIG_FILE"
  	exit 0
	;;
# Disable wpa_supplicant and dhclient
  "-d") killnet
  	exit 0
esac

# Check if the config exists before trying to connect
# Kill all running wpa_supplicants and dhclients before starting a new one
[ -f /etc/wpa_supplicant.conf ] &&
{ 
killnet;
wpa_supplicant -B -i "$1" -c "$CONFIG_FILE";
dhclient "$1" &&
echo "nameserver 176.58.106.228" > /etc/resolv.conf
}
