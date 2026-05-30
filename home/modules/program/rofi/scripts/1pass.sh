#!/usr/bin/env bash

# https://github.com/applejag/qutebrowser/blob/b89fafb27f2246e79c200fc717920338b2df9db9/misc/userscripts/qute-1pass

TOKEN_CACHE="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}/1pass.token"

dmenu-prompt() {
    local PROMPT="$1"

    if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wofi >/dev/null; then
        wofi --dmenu --insensitive --prompt "$PROMPT"
        return
    fi

    rofi -dmenu -i -p "$PROMPT"
}

dmenu-prompt-pass() {
    local PROMPT="$1"

    if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wofi >/dev/null; then
        wofi --lines 1 --dmenu --password --prompt "$PROMPT"
        return
    fi

    rofi -dmenu -password -p "$PROMPT"
}

clipboard-copy() {
    if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy >/dev/null; then
        wl-copy --trim-newline
        return
    fi

    xclip -in -selection clipboard
}

if ! command -v op > /dev/null; then
    echo "message-error 'Missing required command-line tool: op'"
    exit 1
fi

if ! command -v jq > /dev/null; then
    echo "message-error 'Missing required command-line tool: jq'"
    exit 1
fi

OP_VERSION="$(op --version)"
OP_MAJOR_VERSION="$(echo "$OP_VERSION" | grep --only-matching '^[0-9]')"

if [[ "$OP_MAJOR_VERSION" -lt 2 ]]; then
    echo "message-error 'Requires op CLI v2.0.0 or higher, but got: $OP_VERSION'"
    exit 1
fi

JQ_TITLE_EXPR='.title + " (in vault \"" + .vault.name + "\")"'

OP_ACCOUNT="$(op account list --format=json 2>/dev/null \
    | jq -r '.[0] | (.shorthand // .user_uuid // .account_uuid // empty)')"

if [[ -z "$OP_ACCOUNT" ]]; then
    echo "message-error '1Password account not configured. Run: op account add'"
    exit 1
fi

save_token() {
    [[ -n "$1" ]] || return 0
    (umask 077 && printf '%s' "$1" > "$TOKEN_CACHE")
}

TOKEN=""
if [ -r "$TOKEN_CACHE" ]; then
    TOKEN="$(< "$TOKEN_CACHE")"
fi

if [[ -z "$TOKEN" ]] || ! env "OP_SESSION_${OP_ACCOUNT}=$TOKEN" op whoami >/dev/null 2>&1; then
    TOKEN="$(dmenu-prompt-pass "1password: " | op signin --raw)" || TOKEN=""
    save_token "$TOKEN"
fi

if [[ -z "$TOKEN" ]]; then
    echo "message-error 'Wrong master password'"
    exit 1
fi

export "OP_SESSION_${OP_ACCOUNT}=$TOKEN"

if ! MATCHING_ITEMS="$(op item list --cache --format=json)"; then
    echo "message-error 'Failed to list items.'"
    exit 1
fi

MATCHING_COUNT="$(echo "$MATCHING_ITEMS" | jq -r 'length')"
echo "message-info 'Found $MATCHING_COUNT entries'"

UUID=""
TITLE="$(echo "$MATCHING_ITEMS" | jq -r '.[] | '"$JQ_TITLE_EXPR" | dmenu-prompt "Select item")" || TITLE=""
if [ -n "$TITLE" ]; then
    UUID=$(echo "$MATCHING_ITEMS" | jq --arg title "$TITLE" -r '[.[] | select('"$JQ_TITLE_EXPR"' == $title).id] | first // ""') || UUID=""
else
    UUID=""
fi

if [[ -z "$UUID" ]]; then
    echo "message-error 'No items picked.'"
    exit 1
fi

PROPERTIES="$(op item get --cache --format=json "$UUID" | jq '.fields | map(select(.value != null))')"
PROPERTIES_COUNT=$(echo "$PROPERTIES" | jq -r 'length')

if [ -z "$PROPERTIES" ]; then
    echo "message-error 'No values found in matched properties by $TITLE'"
    exit 1
elif [[ "$PROPERTIES_COUNT" == 1 ]]; then
    echo "message-info 'Copied selected value'"
    echo "$PROPERTIES" | jq -r '.[0].value' | clipboard-copy
else
    echo "message-info 'Found $PROPERTIES_COUNT properties'"
    JQ_REVEALED_PROPS_EXPR='map(select(.type != "CONCEALED")) | map(.label + ": " + .value)'
    JQ_CONCEALED_PROPS_EXPR='map(select(.type == "CONCEALED")) | map(.label + ": <CONCEALED>")'
    JQ_PROPS_EXPR="(${JQ_CONCEALED_PROPS_EXPR}) + (${JQ_REVEALED_PROPS_EXPR}) | .[]"
    TITLE="$(echo "$PROPERTIES" | jq -r "${JQ_PROPS_EXPR}" | dmenu-prompt "Select property")" || TITLE=""
    if [ -n "$TITLE" ]; then
        VALUE=$(echo "$PROPERTIES" | jq --arg title "$TITLE" -r 'map([.] | select('"$JQ_PROPS_EXPR"' == $title) | .[].value) | first // ""') || VALUE=""
        echo "$VALUE" | clipboard-copy
        echo "message-info 'Copied selected value'"
    else
        echo "message-error 'No matched properties'"
    fi
fi

