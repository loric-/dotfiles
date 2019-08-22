#!/bin/bash

# Get CRTC information
max_crtc=$(xrandr --listproviders | grep -oP 'crtcs:\s*\K\d+')

# $1 is output name
# $2 is the previous monitor
# if no previous monitor, the output is set as primary
# if xrandr fails, try a different crtc
function xrandrEnable() {
    local output=$1

    local previous=""
    local primary="--primary"
    if [[ -n $2 ]]; then
        previous="--right-of $2"
        primary=""
    fi

    # Try to set monitor with auto crtc
    xrandr --output $output --pos 0x0 --auto $primary $previous

    # If did not work, try manually setting the crtc
    if [ "$?" -ne 0 ]; then
        for crtc in $(seq 0 $((max_crtc - 1))); do
            xrandr --output $output --crtc $crtc --pos 0x0 --auto $primary $previous && break
        done
    fi
}

# Get connected outputs
connected_outputs=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')
connected_outputs=($connected_outputs)
connected_outputs_count=${#connected_outputs[@]}

# Get disconnected outputs
disconnected_outputs=$(xrandr | grep '\Wdisconnected' | awk '{ print $1 }')
disconnected_outputs=($disconnected_outputs)

# Turn off disconnected displays
for output in ${disconnected_outputs[@]}; do
    xrandr --output $output --off
done

# Turn off connected displays to reset them
# before enabling them again
for output in ${connected_outputs[@]}; do
    xrandr --output $output --off
done

# Get internal monitor (first monitor)
internal=${connected_outputs[0]}
only_internal=1

# Update internal
xrandrEnable $internal

# Update additional displays
previous=$internal
for output in ${connected_outputs[@]}; do
    if [[ ! $output =~ ^$internal.*$ ]]; then
        xrandrEnable $output $previous
        previous=$output
    fi
done

# Reload i3
i3-msg reload

# Restart Polybar
~/.config/polybar/launch.sh
