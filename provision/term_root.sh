#!/bin/bash
#
# should be run as root

set -e

# Install ppa
apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:jonathonf/vim \
    && add-apt-repository -y ppa:git-core/ppa

# Install packages
apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      acpi \
      ansible \
      apt-transport-https \
      autojump \
      ca-certificates \
      ctags \
      curl \
      dos2unix \
      git \
      glances \
      graphviz \
      htop \
      httpie \
      iftop \
      iotop \
      iputils-ping \
      jq \
      man-db \
      mercurial \
      moreutils \
      ncdu \
      net-tools \
      netcat \
      nethogs \
      nload \
      openvpn \
      pv \
      python \
      python-pip \
      python3 \
      python3-pip \
      ranger \
      software-properties-common \
      ssh \
      stress \
      sudo \
      tcpdump \
      telnet \
      tmux \
      traceroute \
      tree \
      tty-clock \
      vim-gtk3 \
      wget \
      wordnet \
      zsh

# Allow users to use sudo without password
echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install golang
rm -rf /usr/local/go*
wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz \
    && tar -xvf go1.12.6.linux-amd64.tar.gz \
    && mv go /usr/local \
    && rm go*

# Install python packages
pip install \
  speedtest-cli \
  cheat \
  http-prompt \
  --upgrade

pip3 install \
  bpython \
  ipython \
  asciinema \
  --upgrade

# Install shally
rm -rf /usr/local/bin/shally
wget https://raw.githubusercontent.com/lobre/shally/master/shally \
  && chmod +x shally \
  && mv shally /usr/local/bin

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Delete apt cache
apt-get clean
rm -r /var/crash/*
rm -r /var/cache/*
