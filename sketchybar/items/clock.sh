#!/bin/zsh

sketchybar -m --add item clock right \
  --set clock update_freq=5                          \
      script="${plugins}/clock.sh" \
      label.padding_left=0                           \
      background.color="${default_label_color}"      \
      background.height=28

sketchybar -m --add item clock_logo right      \
  --set clock_logo icon=                  \
      background.color="${calendar_color}" \
      background.height=28
