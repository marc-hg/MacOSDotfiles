#!/bin/bash

# Function to format bytes
format_bytes() {
    local bytes=$1
    if (( bytes > 1073741824 )); then
        echo "$(( bytes / 1073741824 ))G"
    elif (( bytes > 1048576 )); then
        echo "$(( bytes / 1048576 ))M"
    elif (( bytes > 1024 )); then
        echo "$(( bytes / 1024 ))K"
    else
        echo "${bytes}B"
    fi
}

# Get network interface (usually en0 for main network)
INTERFACE=$(route get default | grep interface | awk '{print $2}')

# Get current network stats
CURRENT_STATS=$(netstat -ibn | grep "$INTERFACE" | head -1)
RX_BYTES=$(echo "$CURRENT_STATS" | awk '{print $7}')
TX_BYTES=$(echo "$CURRENT_STATS" | awk '{print $10}')

# Store/read previous values
CACHE_FILE="/tmp/sketchybar_network_cache"
if [[ -f "$CACHE_FILE" ]]; then
    source "$CACHE_FILE"
    
    # Calculate rates (bytes per second)
    TIME_DIFF=2  # Update frequency is 2 seconds
    RX_RATE=$(( (RX_BYTES - PREV_RX_BYTES) / TIME_DIFF ))
    TX_RATE=$(( (TX_BYTES - PREV_TX_BYTES) / TIME_DIFF ))
    
    # Format the rates
    RX_FORMATTED=$(format_bytes $RX_RATE)
    TX_FORMATTED=$(format_bytes $TX_RATE)
    
    # Update the items
    if [[ "$NAME" == "network.down" ]]; then
        sketchybar --set $NAME label="↓$RX_FORMATTED"
    elif [[ "$NAME" == "network.up" ]]; then
        sketchybar --set $NAME label="↑$TX_FORMATTED"
    fi
fi

# Store current values for next run
echo "PREV_RX_BYTES=$RX_BYTES" > "$CACHE_FILE"
echo "PREV_TX_BYTES=$TX_BYTES" >> "$CACHE_FILE" 