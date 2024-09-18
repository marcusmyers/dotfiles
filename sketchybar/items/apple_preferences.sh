#!/bin/zsh

sketchybar -m --add item apple.logo left                                          \
  --set apple.logo icon="􀣺"                                                       \
                   icon.font="SF Pro:Black:16.0"                                  \
                   background.color="${red_color}"                                \
                   background.height=28                                           \
                   label.drawing=off                                              \
                   click_script="sketchybar -m --set \$NAME popup.drawing=toggle" \
                   popup.background.border_width=2                                \
                   popup.background.corner_radius=3                               \
                   popup.background.color="${default_label_color}" \
                   popup.background.border_color="${red_color}"                   \
                                                                                  \
  --add item apple.preferences popup.apple.logo                                   \
  --set apple.preferences icon=􀺽                                                  \
        label="Preferences"                                                       \
        click_script="open -a 'System Preferences'; sketchybar -m --set apple.logo popup.drawing=off" \
        label.padding_right=10 \
  --add item apple.activity popup.apple.logo                                      \
  --set apple.activity icon=􀒓                                                     \
        label="Activity"                                                          \
        click_script="open -a 'Activity Monitor'; sketchybar -m --set apple.logo popup.drawing=off" \
        label.padding_right=10 \
  --add item apple.lock popup.apple.logo                                          \
  --set apple.lock icon=􀒳                                                         \
        label="Lock Screen"                                                       \
        label.padding_right=10 \
        click_script="pmset displaysleepnow; sketchybar -m --set apple.logo popup.drawing=off"
