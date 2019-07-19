#!/bin/bash
#
# should be run as root

set -e

# Define default user if not provided
user=dev
if [[ -n $1 ]]; then
    user=$1
fi

# Create user
useradd --create-home --home-dir /home/$user $user
chown -R $user:$user /home/$user
echo "$user:$user" | chpasswd

# Add user to sudo group
usermod -aG sudo $user
