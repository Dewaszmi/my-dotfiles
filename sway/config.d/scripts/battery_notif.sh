#!/bin/sh

min_bat=40
max_bat=80
seconds=5

last_notified_bat=""
last_status=""

while true; do
  cur_bat=$(cat /sys/class/power_supply/BAT1/capacity)
  status=$(cat /sys/class/power_supply/BAT1/status)

  if [ "$status" != "$last_status" ]; then
    last_notified_bat=""
    last_status="$status"
  fi

  if [ "$status" = "Discharging" ] && [ $cur_bat -le $min_bat ]; then
    threshold=$(((cur_bat - 1) / 5 * 5))

    if [ "$last_notified_bat" != "$threshold" ]; then
      notify-send "Low Battery Level" "Battery is at $cur_bat%. Please plug in the charger"
      last_notified_bat="$threshold"
    fi
  elif [ "$status" = "Charging" ] && [ $cur_bat -ge $max_bat ]; then
    threshold=$((cur_bat / 5 * 5))

    if [ "$last_notified_bat" != "$threshold" ]; then
      notify-send "High Battery Level" "Battery is at $cur_bat%. Please unplug the charger"
      last_notified_bat="$threshold"
    fi
  fi

  sleep $seconds
done
