#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $CHARGING != "" && $BATT_PERCENT != "" ]]; then
  sketchybar -m --set battery label=$(printf "${BATT_PERCENT}%%")
  sketchybar -m --set power_logo icon=􀢋

  exit 0
else
  sketchybar -m --set battery label=""
  exit 0
fi

case ${BATT_PERCENT} in
   100) ICON="􀛨" ;;
    9[0-9]) ICON="􀛨" ;;
    8[0-9]) ICON="􀺸" ;;
    7[0-9]) ICON="􀺸" ;;
    6[0-9]) ICON="􀺸" ;;
    5[0-9]) ICON="􀺶" ;;
    4[0-9]) ICON="􀺶" ;;
    3[0-9]) ICON="􀺶" ;;
    2[0-9]) ICON="􀛩" ;;
    1[0-9]) ICON="􀛩" ;;
    *) ICON="􀛩"
esac

sketchybar -m --set battery \
  label=$(printf "${BATT_PERCENT}%%")
sketchybar -m --set power_logo \
  icon=$ICON \
