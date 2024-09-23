#!/bin/zsh

sketchybar -m --add space docs left            \
  --set docs associated_space=4                 \
      icon.highlight_color=0xfffab402           \
      label.highlight_color=0xfffab402          \
      label.padding_right=10                    \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=                                    \
      label=docs                                \
      click_script="yabai -m space --focus 4"
