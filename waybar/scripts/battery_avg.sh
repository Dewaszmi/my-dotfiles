#!/bin/bash

HISTORY_FILE="/tmp/battery_time_history"
MAX_ENTRIES=10  # 10 entries * 10 second intervals

# Get current battery info
CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

# Get time estimate (if available)
TIME_TO_EMPTY=$(upower -i $(upower -e | grep 'BAT') | grep -E "time to empty" | awk '{print $4 " " $5}')
TIME_TO_FULL=$(upower -i $(upower -e | grep 'BAT') | grep -E "time to full" | awk '{print $4 " " $5}')

# Convert time to minutes for averaging
convert_to_minutes() {
    local time_str="$1"
    if [[ $time_str =~ ([0-9]+):([0-9]+) ]]; then
        echo $((${BASH_REMATCH[1]} * 60 + ${BASH_REMATCH[2]}))
    elif [[ $time_str =~ ([0-9]+\.?[0-9]*)[[:space:]]hours? ]]; then
        echo $(echo "${BASH_REMATCH[1]} * 60" | bc)
    elif [[ $time_str =~ ([0-9]+)[[:space:]]minutes? ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "0"
    fi
}

# Get current time in minutes
if [[ $STATUS == "Charging" ]]; then
    CURRENT_TIME=$(convert_to_minutes "$TIME_TO_FULL")
else
    CURRENT_TIME=$(convert_to_minutes "$TIME_TO_EMPTY")
fi

# Add current time to history
echo "$CURRENT_TIME" >> "$HISTORY_FILE"

# Keep only last MAX_ENTRIES
tail -n $MAX_ENTRIES "$HISTORY_FILE" > "${HISTORY_FILE}.tmp"
mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"

# Calculate average
if [[ -f "$HISTORY_FILE" && -s "$HISTORY_FILE" ]]; then
    AVG_MINUTES=$(awk '{sum+=$1; count++} END {if(count>0) print int(sum/count); else print 0}' "$HISTORY_FILE")
else
    AVG_MINUTES=$CURRENT_TIME
fi

# Convert back to hours:minutes
if [[ $AVG_MINUTES -gt 0 ]]; then
    HOURS=$((AVG_MINUTES / 60))
    MINS=$((AVG_MINUTES % 60))
    if [[ $HOURS -gt 0 ]]; then
        AVG_TIME="${HOURS}:$(printf "%02d" $MINS)"
    else
        AVG_TIME="${MINS}m"
    fi
else
    AVG_TIME="--"
fi

# Output format similar to default battery module
case $STATUS in
    "Charging")
        echo "⚡${CAPACITY}% (${AVG_TIME})"
        ;;
    "Full")
        echo " ${CAPACITY}%"
        ;;
    *)
        echo " ${CAPACITY}% (${AVG_TIME})"
        ;;
esac
