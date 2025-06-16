#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

# Color coding based on usage
if [[ $CPU_PERCENT -ge 80 ]]; then
    COLOR=$RED
elif [[ $CPU_PERCENT -ge 60 ]]; then
    COLOR=$ORANGE
elif [[ $CPU_PERCENT -ge 40 ]]; then
    COLOR=$YELLOW
else
    COLOR=$GREEN
fi

# Update the item
sketchybar --set $NAME label="${CPU_PERCENT}%" \
                  icon.color="$COLOR" \
                  label.color="$COLOR"
