#!/bin/bash
set -e

hist=$HOME/.i3_rename_history

# current workspace num
num=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].num'`

# create history file if first time
if [ ! -f $hist ]; then
    touch $hist
fi

# prompt for name
input=$( cat $hist | rofi -dmenu -p "New name")

# rename
if [ -z "$input" ]
then
    i3-msg "rename workspace to \"$num\""
else
    i3-msg "rename workspace to \"$num:$input\""
fi

# add to history
echo $input >> $hist
