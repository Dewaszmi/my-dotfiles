#!/bin/sh

choice=$(printf "Suspend\nReboot\nShutdown" | wofi --dmenu --prompt="🥺🥺🥺")

case "$choice" in
  Suspend) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
