#!/bin/zsh

sketchybar -m --add space personal left         \
  --set personal associated_display=1           \
      associated_space=1                        \
      icon.highlight_color=0xfffab402           \
      label.highlight_color=0xfffab402          \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=                                   \
      label=personal                            \
      click_script="yabai -m space --focus 1"
