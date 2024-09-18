#!/bin/zsh

sketchybar -m --add space sqm left              \
  --set sqm associated_space=1                  \
      associated_display=1                      \
      icon.font="Hack Nerd Font:Bold:20.0"      \
      icon=                                    \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon.highlight_color=0xff48aa2a           \
      label.highlight_color=0xff48aa2a          \
      label=sqm                                 \
      click_script="yabai -m space --focus 1"
