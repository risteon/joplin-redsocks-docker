FROM ubuntu:latest

# Proxy?
ARG DOCKER_PROXY
ENV http_proxy="${DOCKER_PROXY}"
ENV https_proxy="${DOCKER_PROXY}"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Berlin"

RUN set -ex && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  iptables iptables-persistent redsocks curl wget lynx \
  # Joplin
  fuse libfuse-dev \
  # Joplin deps
  sudo libgtk2.0-0

RUN set -ex && \
  apt-get update && \
  apt-get install -y \
  libgtk3.0-cil

RUN set -ex && \
  apt-get update && \
  apt-get install -y \
  libxshmfence-dev libnss3 libatk-bridge2.0-0 libdrm2 libgbm1 \
  # show emojis in Joplin notebooks
  fonts-noto-color-emoji \
  xdg-utils

RUN set -ex && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  libasound2

# just for debugging
#RUN apt-get install htop vim iproute2 -qy

# Joplin user. Same UID/GID to use xserver
ARG UID
ARG GID
RUN groupadd -g "${GID}" joplin
RUN useradd -u "${UID}" -g "${GID}" -ms /bin/bash joplin && echo "joplin:joplin" | chpasswd && adduser joplin sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Redsocks config and container script
WORKDIR /home/joplin
COPY entrypoint.sh .
COPY redsocks.conf .
RUN rm -f /etc/redsocks.conf
RUN ln -s "$(pwd)/redsocks.conf" /etc/redsocks.conf

# Joplin
USER joplin
ENV TERM=screen-256color
RUN wget https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh && \
  chmod +x Joplin_install_and_update.sh && \
  ./Joplin_install_and_update.sh && \
  rm Joplin_install_and_update.sh

# remote proxy var. Only used for this build.
ENV http_proxy=""
ENV https_proxy=""

#ENTRYPOINT /bin/bash run.sh
CMD [ "sh", "/home/joplin/entrypoint.sh" ]

