#!/bin/bash
# echo "Configuration:"
# echo "PROXY_SERVER=$PROXY_SERVER"
# echo "PROXY_PORT=$PROXY_PORT"
# echo "Setting config variables"
# sed -i "s/vPROXY-SERVER/$PROXY_SERVER/g" /etc/redsocks.conf
# sed -i "s/vPROXY-PORT/$PROXY_PORT/g" /etc/redsocks.conf
# echo "Restarting redsocks and redirecting traffic via iptables"
# /etc/init.d/redsocks restart
# iptables -t nat -A OUTPUT  -p tcp --dport 21 -j REDIRECT --to-port 12345
# Run app
# echo "Testing https access using: wget storage.risteon.xyz"
set -ex

# wget google.com
# wget storage.risteon.xyz

sudo iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDIRECT --to-port 12345
sudo iptables -t nat -A OUTPUT -p tcp --dport 443 -j REDIRECT --to-port 12346

sudo service redsocks start

./.joplin/Joplin.AppImage

