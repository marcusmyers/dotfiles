#!/bin/zsh

sketchybar -m --add space browse left         \
  --set browse associated_space=1              \
      icon.highlight_color=0xfffab402           \
      label.highlight_color=0xfffab402          \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=􀎬                                    \
      label=browse                            \
      click_script="yabai -m space --focus 1"
