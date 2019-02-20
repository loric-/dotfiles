#!/bin/bash

# Install required packages
apt-get install -y build-essential gcc make perl dkms

# Mount the disk image
cd /tmp
mkdir /tmp/guestadditions
mount -t iso9660 -o loop /home/dev/VBoxGuestAdditions.iso /tmp/guestadditions

# Install the drivers
/tmp/guestadditions/VBoxLinuxAdditions.run

# Cleanup
umount guestadditions
rm -rf guestadditions /home/dev/VBoxGuestAdditions.iso