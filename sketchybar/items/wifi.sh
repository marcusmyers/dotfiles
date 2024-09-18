#!/bin/bash

sketchybar -m --add item wifi right \
  --set wifi update_freq=15 \
     associated_display=1 \
     background.color="${default_label_color}" \
     background.height=28 \
     script="${plugins}/network.sh"

sketchybar -m --add item wifi_logo right \
  --set wifi_logo icon=\
      associated_display=1 \
      background.color="${orange_color}" \
      background.height=28
