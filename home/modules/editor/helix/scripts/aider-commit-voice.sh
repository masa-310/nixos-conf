#!/usr/bin/env sh

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/aider-spawn.sh

echo "\n\n" | wezterm cli send-text --pane-id $right_pane_id --no-paste
