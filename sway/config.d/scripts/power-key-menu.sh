#!/bin/sh

choice=$(printf "Suspend\nReboot\nShutdown" | wofi --dmenu --prompt="papa 😢😢😢")

case "$choice" in
  Suspend) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
