#!/bin/bash
sudo docker run -it --rm --network=dproxy --cap-add NET_ADMIN --cap-add SYS_ADMIN --security-opt apparmor:unconfined --device /dev/fuse -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop:rw -v $HOME/.config/Joplin:/home/joplin/.config/Joplin:rw joplin-redsocks
