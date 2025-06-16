#!/bin/bash

cpu_item=(
  icon="CPU"
  icon.font="$FONT:Bold:12.0"
  label.font="$FONT:Bold:12.0"
  label="--"
  padding_right=10
  update_freq=4
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu right              \
           --set cpu "${cpu_item[@]}"
