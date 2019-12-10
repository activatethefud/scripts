#!/bin/sh

# Host an Access Point with optional networking
# Usage <script> <ssid> <password> <channel>

# Check for script arguments
if [ -z "$1" ] || [ -z "$3" ]; then
	printf "Bad or no arguments given!\\nUsage <script> <ssid> <password> <channel>\\n"
	exit 1
fi

# Disable apache because this script is not for attacking
systemctl stop apache2

# Kill troublesome background proccesses
airmon-ng check kill

dnsmasq_generate_config() { 
	echo "no-resolv"
	echo "interface=$BDCST_INTERFACE"
	echo "dhcp-range=192.168.1.2,192.168.1.100,12h"
	echo "dhcp-option=3,192.168.1.1"
	echo "dhcp-option=6,192.168.1.1"
	echo "server=1.1.1.1"
	echo "listen-address=127.0.0.1"
}

hostapd_generate_config() {
	echo "interface=$BDCST_INTERFACE"
	echo "driver=nl80211"
	echo "ssid=$ESSID"
	echo "hw_mode=g"
	echo "channel=$CHANNEL"
	echo "macaddr_acl=0"
	echo "ignore_broadcast_ssid=0"
	echo "auth_algs=1"
	if [ -n "$PASSWD" ]; then
		echo "wpa=2"
		echo "wpa_key_mgmt=WPA-PSK"
		echo "rsn_pairwise=TKIP"
		echo "wpa_passphrase=$PASSWD"
	fi
}

killcheck() {
	pkill -9 hostapd
	pkill -9 dnsmasq
}

export BDCST_INTERFACE
export NET_INTERFACE
export ESSID
export PASSWD
export CHANNEL
export HOSTAPD_CONFIG

ESSID="$1"
PASSWD="$2"
CHANNEL="$3"
HOSTAPD_CONFIG="./configs/hostapd.conf"

# Set the broadcast and internet interface
echo "Selecting broadcast interface."
BDCST_INTERFACE="$(./pick_interface.sh)"
echo "Selecting internet interface."
NET_INTERFACE="$(./pick_interface.sh)"

# Change the mac addresses
./macchange.sh "$BDCST_INTERFACE"
./macchange.sh "$NET_INTERFACE"

# Increase the power of the broadcast interface
./txpower.sh "$BDCST_INTERFACE"

# Set the broadcast interface to monitor mode
./monitor_mode.sh "$BDCST_INTERFACE"

# Generate the custom hostapd config and start the service
killcheck
hostapd_generate_config > "$HOSTAPD_CONFIG"
hostapd -t -K -dd -B "$HOSTAPD_CONFIG" > ./hostapd_log

# Enable IP forwarding in the kernel
./ip_forwarding.sh -e

# Configure IP tables for forwarding
# Flush it down the drain first
iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -o "$NET_INTERFACE" -j MASQUERADE
iptables -A FORWARD -i "$NET_INTERFACE" -o "$BDCST_INTERFACE" -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
#iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.1:80
#iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i "$BDCST_INTERFACE" -o "$NET_INTERFACE" -j ACCEPT

# Start the internet
/usr/bin/internet whatever -d
/usr/bin/internet "$NET_INTERFACE"

# Assign an IP to the new Access Point and configure the routing table
ifconfig "$BDCST_INTERFACE" up 192.168.1.1 netmask 255.255.255.0
route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1

# Configure dnsmasq and enable everything
dnsmasq_generate_config > /etc/dnsmasq.conf
dnsmasq
