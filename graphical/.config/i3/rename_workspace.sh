#!/bin/bash
set -e

prompt="New name: "
num=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].num'`
old_name=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].name'`

# Do the renaming
i3-input -F "rename workspace to \"$num:%s\"" -P "$prompt"

# Reset to num if input empty
name=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].name'`
if [[ ${name%"$prefix"} =~ ^[0-9]+:$ ]]; then
  i3-msg "rename workspace to \"$num\""
fi
