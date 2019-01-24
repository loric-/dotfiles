#!/bin/bash
set -e

prompt="New name: "
prefix=""
separator=" "
num=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].num'`
old_name=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].name'`

# Persist first letter if uppercase single letter (e.g "T -")
regex="^[0-9]+:([A-Z]([[:space:]][^A-Za-z0-9])?)"
if [[ "$old_name" =~ $regex ]]; then
    prefix="${BASH_REMATCH[1]}"

    # Add separator if single letter
    if [ ${#prefix} -eq 1 ]; then
        separator="  "
    fi

    prefix="$prefix$separator"
    prompt="New name: $prefix"
fi

# Do the renaming
i3-input -F "rename workspace to \"$num:$prefix%s\"" -P "$prompt"

# Reset to num if input empty
name=`i3-msg -t get_workspaces | jq -r 'map(select(.focused == true))[0].name'`
if [[ ${name%"$prefix"} =~ ^[0-9]+:$ ]]; then
  i3-msg "rename workspace to \"$num\""
fi
