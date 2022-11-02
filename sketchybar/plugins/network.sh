#!/bin/bash

output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
airport=$(echo "$output" | grep 'AirPort' | awk -F': ' '{print $2}')

if [ "$airport" = "Off" ]; then
  sketchybar -m --set wifi label="Offline"
else
  sketchybar -m --set wifi label="$(echo "$output" | grep ' SSID' | xargs | awk -F': ' 'echo $2') $(echo "$output" | grep 'lastTxRate' | awk -F': ' '{print $2}') Mb/s"
fi
