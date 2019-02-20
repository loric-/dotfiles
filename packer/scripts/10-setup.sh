#!/bin/bash

# Upgrade system
apt-get -y update
apt-get -y dist-upgrade --force-yes

# Let use sudo without password
apt-get install -y sudo
echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
usermod -aG sudo dev

# Decrease GRUB wait time
echo "GRUB_RECORDFAIL_TIMEOUT=5" | tee -a /etc/default/grub > /dev/null && update-grub
