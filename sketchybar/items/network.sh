#!/bin/bash

network_down=(
  label.font="$FONT:Heavy:12"
  label=↓
  y_offset=-4
  padding_right=5
  width=45
  icon.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/network.sh"
)

network_up=(
  label.font="$FONT:Heavy:12"
  label=↑
  y_offset=-4
  padding_right=15
  width=45
  icon.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network.down right          \
           --set network.down "${network_down[@]}" \
                                                   \
           --add item network.up right             \
           --set network.up "${network_up[@]}" 