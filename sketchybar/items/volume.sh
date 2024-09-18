#!/bin/zsh

sketchybar -m --add item volume right \
  --set volume script="${plugins}/volume.sh" \
      background.color=0xff3B4252 \
      background.height=28 \
      label.padding_right=5 \
      update_freq=5

sketchybar -m --add item volume_logo right \
  --set volume_logo icon= \
      background.color=0xff81A1C1 \
      background.height=28
