# Make sure to use gid and uid for own user for xserver to work
sudo docker build -t joplin-redsocks 
# Make sure to have px-proxy on localhost 3129 with docker network in gateway allow list.

# Docker run (see run.sh):
sudo docker run -it --rm --network=dproxy --cap-add NET_ADMIN --cap-add SYS_ADMIN --security-opt apparmor:unconfined --device /dev/fuse -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop:rw -v $HOME/.config/Joplin:/home/joplin/.config/Joplin:rw joplin-redsocks

