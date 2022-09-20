# Bundle Joplin with Redsocks (Docker Image)

The note-taking app [Joplin](https://joplinapp.org/) does not support network connections through a proxy.
This repository contains a docker image to bundle Joplin with Redsocks.
This enables the use of Joplins synchronization features behind a proxy.

Redsocks allows to redirect all TCP connections to a SOCKS or HTTP proxy.
I'm using px-proxy on localhost (http proxy). Just adapt `redsocks.conf` to your needs.

## Build Image
See `DOCKER_PROXY` argument in `build.sh` to build while behind a proxy (again, I'm using px-proxy).

Just run:
`bash build.sh`

## Run container (see run.sh)

```
docker run -it --rm \
  --cap-add NET_ADMIN \  # need NET_ADMIN cap to use iptables
  --cap-add SYS_ADMIN --security-opt apparmor:unconfined --device /dev/fuse \  # need this to run Joplin with FUSE
  -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix \  # use xserver
  -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop:rw -v $HOME/.config/Joplin:/home/joplin/.config/Joplin:rw \  # mount config dirs
  joplin-redsocks
```
