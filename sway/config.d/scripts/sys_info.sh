#!/bin/bash

cpu=$(awk '/^cpu / {usage=($2+$4)*100/($2+$4+$5); printf "%.1f%%", usage}' /proc/stat)
mem=$(free -h | awk '/^Mem:/ {printf "%s/%s", $3, $2}')
temp="N/A"
echo "{\"cpu\": \"CPUeww logs: $cpu\", \"mem\": \"MEM: $mem\", \"temp\": \"TEMP: $temp\"}"