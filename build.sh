#!/bin/bash
set -eux

# If you build this image behind a proxy, set this var to px-proxy:
: "${DOCKER_PROXY:=http://172.17.0.1:3128}"

# get current user uid and gid to replicate with the docker user
uid=$(id -u "$USER")
gid=$(id -g "$USER")

sudo docker build . \
  --build-arg DOCKER_PROXY=$DOCKER_PROXY \
  --build-arg UID=$uid \
  --build-arg GID=$gid \
  -t joplin-redsocks

