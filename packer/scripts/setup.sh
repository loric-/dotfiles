#!/bin/bash

# Upgrade system
apt-get -y update
apt-get -y dist-upgrade --force-yes

# Enable autologin
sed -i "s/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/g" /etc/gdm3/custom.conf && \
sed -i "s/#  AutomaticLogin = user1/AutomaticLogin = dev/g" /etc/gdm3/custom.conf

# Decrease GRUB wait time
echo "GRUB_RECORDFAIL_TIMEOUT=5" | tee -a /etc/default/grub > /dev/null && update-grub