#!/bin/zsh

sketchybar -m --add space slack left            \
  --set slack associated_space=5                \
      icon.highlight_color=0xfffab402           \
      label.highlight_color=0xfffab402          \
      label.padding_right=10                    \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=                                    \
      label=slack                               \
      click_script="yabai -m space --focus 5"


