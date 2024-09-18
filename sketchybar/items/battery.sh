#!/bin/zsh

sketchybar -m --add item battery right            \
  --set battery update_freq=15                    \
        associated_display=1                      \
        script="${plugins}/power.sh"              \
        background.color="${default_label_color}" \
        background.height=28

sketchybar -m --add item power_logo right             \
              --set power_logo \ # icon=⏻              \
                    associated_display=1              \
                    background.color="${power_color}" \
                    background.height=28
