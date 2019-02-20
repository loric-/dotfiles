#!/bin/bash

# Install sound via alsa kernel modules
apt-add-repository -y ppa:ubuntu-audio-dev/alsa-daily
apt-get update
apt-get install -y oem-audio-hda-daily-dkms
modprobe snd-hda-intel

# Fix sound
echo "# Sound Workaround"              | tee -a /etc/pulse/daemon.conf
echo "default-sample-rate = 48000"     | tee -a /etc/pulse/daemon.conf
echo "alternate-sample-rate = 44100"   | tee -a /etc/pulse/daemon.conf
echo "default-fragments = 2"           | tee -a /etc/pulse/daemon.conf
echo "default-fragment-size-msec = 55" | tee -a /etc/pulse/daemon.conf