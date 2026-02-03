#!/usr/bin/env sh

AIDER_BIN=~/.local/bin/cecli

right_pane_id=$(wezterm cli get-pane-direction right)
is_spawned=false

if [ -z "${right_pane_id}" ]; then
 right_pane_id=$(wezterm cli split-pane --right --percent 40 -- $AIDER_BIN --watch-files --no-gitignore "$@")
 is_spawned=true
fi

right_program=$(wezterm cli list | awk -v pane_id="$right_pane_id" '$3==pane_id { print $6 }')

if [ "$is_spawned" = false ] && [ "$right_program" != "python3.12" ]; then
 echo "program running on right pane should be aider. got: $right_program"
 exit 1
fi
