#!/bin/zsh

sketchybar -m --add space hey left                          \
  --set hey associated_display=1                \
      associated_space=4                        \
      icon.font="Hack Nerd Font:Bold:20.0"      \
      background.color="${default_label_color}" \
      background.height=28                      \
      icon=􀍕                                  \
      icon.highlight_color=0xff48aa2a           \
      label.highlight_color=0xff48aa2a          \
      label=hey                                 \
      label.padding_right=10                    \
      click_script="yabai -m space --focus 4"
