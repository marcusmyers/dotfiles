#!/bin/zsh

sketchybar -m --add space terminal left         \
  --set terminal associated_space=2             \
      icon.font="Hack Nerd Font:Bold:19.0"      \
      icon.highlight_color=0xfffff68f           \
      label.highlight_color=0xfffff68f          \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=                                    \
      label=terminal                            \
      click_script="yabai -m space --focus 2"
