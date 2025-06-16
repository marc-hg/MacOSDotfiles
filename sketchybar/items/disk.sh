#!/bin/bash

disk_item=(
  icon="SSD"
  icon.font="$FONT:Bold:12.0"
  label.font="$FONT:Bold:12.0"
  label="--"
  padding_right=10
  update_freq=30
  script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right              \
           --set disk "${disk_item[@]}" 