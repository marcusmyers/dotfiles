#!/bin/zsh

sketchybar -m --add item weather right \
  --set weather update_freq=1800 \
  --set weather associated_display=1 \
  --set weather background.color="${default_label_color}" background.height=28 \
  --set weather script="${plugins}/weather.sh" \
  --set weather click_script="open https://darksky.net/forecast/41.3741,-84.156/us12/en"

sketchybar -m --add item weather_logo right \
  --set weather_logo icon=                 \
        associated_display=1                \
        background.height=28                \
        background.color="${bright_orange}"
