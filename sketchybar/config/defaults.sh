#!/bin/zsh

# if [[ $internal_display == "Internal" ]]; then
#   bar_height=52
# else
bar_height=32
# fi

############## BAR ##############
sketchybar -m --bar height=${bar_height}      \
  border_color=${bar_border_color} \
  border_width=0                   \
  corner_radius=8                  \
  color=${transparent_color}       \
  blur_radius=50                   \
  position=top                     \
  padding_left=10                  \
  padding_right=10                 \
  margin=8                         \
  shadow=off                       \
  y_offset=4

############## GLOBAL DEFAULTS ##############
sketchybar -m --default updates=on                            \
                        drawing=on                            \
                        cache_scripts=on                      \
                        icon.font="Hack Nerd Font:Bold:18.0"  \
                        icon.color=0xffffffff                 \
                        label.font="Hack Nerd Font:Bold:16.0" \
                        label.color=0xffffffff
