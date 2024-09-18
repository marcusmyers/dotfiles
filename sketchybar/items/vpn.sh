#!/bin/bash

sketchybar -m --add item vpn right \
  --set vpn update_freq=10 \
  --set vpn script="${plugins}/vpn.sh"

sketchybar -m --add item vpn_logo right

sketchybar -m --add item vpn_aws right \
  --set vpn_aws update_freq=10 \
  --set vpn_aws script="${plugins}/vpn.sh"

sketchybar -m --add item vpn_aws_logo right
