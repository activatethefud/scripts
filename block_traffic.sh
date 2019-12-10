#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ]; then
	printf "Bad usage!\\nUsage: <script> <INET_INTERFACE> <BDCST_INTERFACE>\\n"
	exit 1
fi

INTERFACE="$1"
BDCST="$2"

iptables -A OUTPUT -d 172.105.93.33,176.58.106.228 -j ACCEPT
iptables -A INPUT -s 176.58.106.228,172.105.93.33 -j ACCEPT
iptables -A OUTPUT -s 192.168.1.0/24 -d 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -d 192.168.1.0/24 -j ACCEPT
iptables -I INPUT -p udp --sport 67:68 --dport 67:68 -j ACCEPT
iptables -I INPUT -p tcp --sport 443 --dport 443 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 443 --dport 443 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
