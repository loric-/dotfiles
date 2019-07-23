#!/bin/bash
#
# Downloads snap packages locally to be installed during preseed.
# Should be run as root.

cd /var/lib/snapd/seed/snaps

# Download local snap packages
snap download spotify
snap download sublime-text
snap download skype
snap download slack
snap download phpstorm
snap download hugo --channel extended
snap download code
snap download node --channel 9/stable
snap download ripgrep
snap download hub
snap download pocket-casts

# Move assert to correct folder
cd /var/lib/snapd/seed/assertions
mv /var/lib/snapd/seed/snaps/*.assert .
