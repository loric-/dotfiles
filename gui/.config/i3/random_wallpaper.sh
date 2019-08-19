#/bin/bash
#
# Sets the same random wallpaper on all displays

WALL=$(find "$HOME/Pictures/Wallpapers/" -type f | sort -R | tail -1)
feh --no-fehbg --bg-scale "$WALL"
