#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get memory info from vm_stat
VM_STAT=$(vm_stat)

# Extract memory values (pages)
FREE_PAGES=$(echo "$VM_STAT" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
ACTIVE_PAGES=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
INACTIVE_PAGES=$(echo "$VM_STAT" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
WIRED_PAGES=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
COMPRESSED_PAGES=$(echo "$VM_STAT" | grep "Pages stored in compressor" | awk '{print $5}' | sed 's/\.//')

# Get page size (usually 4096 bytes on macOS)
PAGE_SIZE=$(pagesize)

# Calculate memory
TOTAL_PAGES=$((FREE_PAGES + ACTIVE_PAGES + INACTIVE_PAGES + WIRED_PAGES + COMPRESSED_PAGES))
USED_PAGES=$((ACTIVE_PAGES + INACTIVE_PAGES + WIRED_PAGES + COMPRESSED_PAGES))

# Calculate percentage
MEMORY_PERCENT=$(echo "scale=0; $USED_PAGES * 100 / $TOTAL_PAGES" | bc)

# Color coding based on usage
if [[ $MEMORY_PERCENT -ge 90 ]]; then
    COLOR=$RED
elif [[ $MEMORY_PERCENT -ge 75 ]]; then
    COLOR=$ORANGE
elif [[ $MEMORY_PERCENT -ge 60 ]]; then
    COLOR=$YELLOW
else
    COLOR=$GREEN
fi

# Update the item
sketchybar --set $NAME label="${MEMORY_PERCENT}%" \
                  icon.color="$COLOR" \
                  label.color="$COLOR" 