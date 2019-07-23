#/bin/sh
#
# should be run as user (with sudo capabilities)

set -e

# Set double click in browser
gsettings set io.elementary.files.preferences single-click false
