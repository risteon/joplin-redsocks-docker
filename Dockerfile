# https://blog.pxke.me/redsocksdocker.html
FROM ubuntu:latest


ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=http://172.17.0.1:3128

RUN apt-get update
RUN apt-get upgrade -qy
RUN apt-get install iptables iptables-persistent redsocks curl wget lynx -qy
# just for debugging
RUN apt-get install htop vim iproute2 -qy
# Joplin
RUN apt-get install fuse libfuse-dev -qy
# Joplin deps
RUN apt-get install sudo libgtk2.0-0 libgtk3.0-cil libxshmfence-dev libnss3 libatk-bridge2.0-0 libdrm2 libgbm1 -qy
RUN apt-get install fonts-noto-color-emoji -y
RUN apt-get install xdg-utils -y

# Set the working directory to /app
WORKDIR /code
# Copy the current directory contents into the container at /app
ADD . /code
RUN rm -f /etc/redsocks.conf
# RUN ln -s /code/redsocks.conf /etc/redsocks.conf
RUN ln -s /code/redsocks.conf /etc/redsocks.conf
RUN cp /code/entrypoint.sh /entrypoint.sh

# 
RUN groupadd -g 28901 joplin
RUN useradd -u 74224 -g 28901 -ms /bin/bash joplin && echo "joplin:joplin" | chpasswd && adduser joplin sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER joplin

# Joplin
WORKDIR /home/joplin
ENV TERM=screen-256color
RUN wget https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh
RUN chmod +x Joplin_install_and_update.sh && ./Joplin_install_and_update.sh --allow-root

ENV http_proxy=""
ENV https_proxy=""

#ENTRYPOINT /bin/bash run.sh
CMD [ "sh", "/entrypoint.sh" ]

