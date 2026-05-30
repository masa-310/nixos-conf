#!/usr/bin/env bash

PROMPT=$(rofi -dmenu -i -p "Ask AI: ")
if [[ -z "$PROMPT" ]]; then
    echo "No promt provided"
    exit 1
fi

zenity --progress --text="Braining..." --pulsate &
if [[ $? -eq 1 ]]; then
    echo "Zenity failed"
    exit 1
fi

PID=$!

ANSWER=$(echo $PROMPT | aichat)
kill $PID
zenity --info --text="$ANSWER"
