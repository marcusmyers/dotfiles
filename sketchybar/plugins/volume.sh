#!/usr/bin/env bash

PERCENT=$(osascript -e 'output volume of (get volume settings)')%
ACTIVE_SPEAKER=$(/usr/local/bin/SwitchAudioSource -c)
LABEL="${ACTIVE_SPEAKER} - ${PERCENT}"

sketchybar -m --set $NAME label=$(printf "${LABEL}")
