#!/bin/bash
set -ex

sudo iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDIRECT --to-port 12345
sudo iptables -t nat -A OUTPUT -p tcp --dport 443 -j REDIRECT --to-port 12346

sudo service redsocks start

./.joplin/Joplin.AppImage

