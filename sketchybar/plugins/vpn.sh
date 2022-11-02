#!/bin/bash

VPN=$(ifconfig utun10 | grep UP | awk '{print substr($1, 1, length($1)-1)}')
AWSVPN=$(ifconfig utun5 | grep UP | awk '{print substr($1, 1, length($1)-1)}')

if [[ $VPN == "" ]]; then
  sketchybar --set vpn_logo drawing=off
  sketchybar --set vpn drawing=off
else
  sketchybar --set vpn_logo icon= \
                background.height=28 \
                background.color=0xffB48EAD \
                associated_display=1 \
                background.padding_left=5 \
                drawing=on \
  sketchybar --set vpn label="Work VPN" \
                   drawing=on \
                   associated_display=1 \
                   background.color=0xff3B4252 background.height=28
fi

if [[ $AWSVPN == "" ]]; then
  sketchybar --set vpn_aws_logo drawing=off
  sketchybar --set vpn_aws drawing=off
else
  sketchybar --set vpn_aws_logo icon= \
                background.height=28 \
                background.color=0xffB48EAD \
                associated_display=1 \
                background.padding_left=5 \
                drawing=on \
  sketchybar --set vpn_aws label="AWS VPN" \
                   drawing=on \
                   associated_display=1 \
                   background.color=0xff3B4252 background.height=28
fi
