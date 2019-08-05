#!/bin/bash
#
# Downloads snap packages locally to be installed during preseed.
# Should be run as root.

set -e

cd /tmp/

# Download local snap packages
snap download spotify
snap download sublime-text
snap download skype
snap download slack
snap download code
snap download node --channel 9/stable
snap download ripgrep
snap download pocket-casts

# Rename without version numbers
for f in *.{assert,snap}; do
    renamed=$(echo $f | sed -r 's/(.+)_[0-9]+\.(snap|assert)/\1\.\2/')
    mv "$f" "$renamed"
done

# Move snaps to correct folder
mv /tmp/*.snap /var/lib/snapd/seed/snaps/

# Move asserts to correct folder
mv /tmp/*.assert /var/lib/snapd/seed/assertions/
