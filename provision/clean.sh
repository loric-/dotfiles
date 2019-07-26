#!/bin/bash
#
# should be run as root

set -e

# Remove useless packages
apt-get remove -y --purge libreoffice*
apt-get remove -y --purge firefox
apt-get remove -y --purge thunderbird

# Clean
apt-get clean
apt-get -y autoremove
