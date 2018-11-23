#!/bin/sh

# Redirect all IPv4 80 traffic to the pi
echo iptables -t nat -I PREROUTING -i wlan-ap -p tcp --dport 80 -j DNAT --to-destination 10.0.0.1:80 | sudo tee --append  /etc/hostapd/nat.sh > /dev/null 

# Prevent masquarading out ipv4
# This is prevent IPTUNNEL and routing to the internet (Exit node)
sed -i "/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE/d" /etc/hostapd/nat.sh 

# Set nginx to redirect any 404 errors to /
sed "s/}/    error_page 404 =200 \/index.html;\\n}/" /etc/nginx/sites-enabled/main.conf