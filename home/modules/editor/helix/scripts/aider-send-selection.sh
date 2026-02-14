#!/usr/bin/env sh

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/aider-spawn.sh

echo "$1\n" | wezterm cli send-text --pane-id $right_pane_id

wezterm cli activate-pane-direction --pane-id $right_pane_id right
