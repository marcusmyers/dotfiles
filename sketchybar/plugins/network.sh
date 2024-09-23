#!/bin/bash

output=$(sudo wdutil info)
wifi_id=$(echo "$output" | grep 'SSID' | awk -F': ' '{print $2}')

if [ "$wifi_id" = "None" ]; then
  sketchybar -m --set wifi label="Offline"
else
  sketchybar -m --set wifi label="$(echo "$output" | grep 'Tx Rate' | awk -F': ' '{print $2}')"
fi
