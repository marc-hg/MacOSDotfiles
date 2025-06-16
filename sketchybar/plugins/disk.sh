#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get APFS container usage (more accurate for macOS)
APFS_INFO=$(diskutil apfs list | grep -A 2 "Capacity In Use By Volumes:")
if [[ -n "$APFS_INFO" ]]; then
    # Extract used and total capacity from APFS
    USED_BYTES=$(echo "$APFS_INFO" | grep "Capacity In Use By Volumes:" | awk '{print $6}' | tr -d '()')
    TOTAL_BYTES=$(diskutil apfs list | grep "Size (Capacity Ceiling):" | head -1 | awk '{print $4}' | tr -d '()')
    
    # Calculate percentage
    DISK_PERCENT=$(echo "scale=0; $USED_BYTES * 100 / $TOTAL_BYTES" | bc)
else
    # Fallback to df if APFS parsing fails
    DISK_INFO=$(df -h / | tail -1)
    DISK_PERCENT=$(echo "$DISK_INFO" | awk '{print $5}' | sed 's/%//')
fi

# Color coding based on usage
if [[ $DISK_PERCENT -ge 90 ]]; then
    COLOR=$RED
elif [[ $DISK_PERCENT -ge 80 ]]; then
    COLOR=$ORANGE
elif [[ $DISK_PERCENT -ge 70 ]]; then
    COLOR=$YELLOW
else
    COLOR=$GREEN
fi

# Update the item
sketchybar --set $NAME label="${DISK_PERCENT}%" \
                  icon.color="$COLOR" \
                  label.color="$COLOR" 