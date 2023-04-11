#!/bin/bash

display_width=$(yabai -m query --displays | jq '.[].frame.w')
status=$(curl -s 'wttr.in/Napoleon?format=%C+|+%t')
condition=$(echo $status | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
temp=$(echo $status | awk -F '|' '{print $2}')
condition="${condition// /}"
temp="${temp//\+/}"
temp="${temp// /}"

# add more conditions here as appropriate
case "${condition}" in
  "sunny")
    icon=""
    ;;
  "partlycloudy")
    icon=""
    ;;
  "lightrain")
    icon="􀇅"
    ;;
  "overcast")
    icon="􀇕"
    ;;
  *)
    icon="$condition"
    ;;
esac

if [[ $display_width > 1440 ]]; then
  sketchybar --set weather drawing=on
  sktechybar --set weather_logo drawing=on
  sketchybar -m --set weather icon="$icon"
  sketchybar -m --set weather label="$temp"
else
  sketchybar --set weather drawing=off
  sktechybar --set weather_logo drawing=off
fi
