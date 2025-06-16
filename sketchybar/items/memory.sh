#!/bin/bash

memory_item=(
  icon="RAM"
  icon.font="$FONT:Bold:12.0"
  label.font="$FONT:Bold:12.0"
  label="--"
  padding_right=10
  update_freq=4
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right              \
           --set memory "${memory_item[@]}" 