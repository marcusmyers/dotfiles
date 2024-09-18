#!/bin/zsh

sketchybar -m  --add space social left            \
  --set social associated_display="${display_count}" \
      associated_space=3                        \
      icon.highlight_color=0xfffab402           \
      label.highlight_color=0xfffab402          \
      label.padding_right=10                    \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=                                    \
      label=social                              \
      click_script="yabai -m space --focus 3"
