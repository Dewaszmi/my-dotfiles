#!/bin/bash

choice=$(printf "Laptop only\nExternal only\nBoth displays\n" | wofi --dmenu --prompt "Select display mode:")

case "$choice" in
  "Laptop only")
    swaymsg output HDMI-A-1 disable
    swaymsg output eDP-1 enable
    ;;
  "External only")
    swaymsg output eDP-1 disable
    swaymsg output HDMI-A-1 enable
    ;;
  "Both displays")
    swaymsg output eDP-1 enable
    swaymsg output HDMI-A-1 enable
    ;;
esac