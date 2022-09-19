# Joplin behind a proxy with redsocks

The note-taking app [Joplin](https://joplinapp.org/) does not support a proxy via environment variables (`http_proxy`).
This repository contains a simple docker image to bundle Joplin with redsocks to use it behind a proxy.
Redsocks allows to redirect all TCP connections to a SOCKS or HTTPS proxy. I'm using px-proxy on localhost.

## Build Image
See the `DOCKER_PROXY` argument to build while behind a proxy (again, I'm using px-proxy). Check the redsocks.conf file. 
Building the image is different from running the container. While running, px-proxy allows connections from the docker network on 172.18.\* and runs on port 3129.

Script to build image:
`bash build.sh`

## Run container (see run.sh)

```
docker run -it --rm \
  --network=dproxy --cap-add NET_ADMIN \  # own network, need NET_ADMIN to use iptables
  --cap-add SYS_ADMIN --security-opt apparmor:unconfined --device /dev/fuse \  # need this to run Joplin with FUSE
  -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix \  # use xserver
  -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop:rw -v $HOME/.config/Joplin:/home/joplin/.config/Joplin:rw \  # mount config dirs
  joplin-redsocks
```
