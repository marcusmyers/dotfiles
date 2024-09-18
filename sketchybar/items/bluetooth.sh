#!/bin/zsh

sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status" \
   --add item headphones right  \
   --set headphones update_freq=5 \ #icon= \
     associated_display=1 \
     script="${plugins}/ble_headset.sh" \
   --subscribe headphones bluetooth_change

sketchybar -m --add item headphones_logo right
