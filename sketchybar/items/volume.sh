#!/bin/sh

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  script="$PLUGIN_DIR/volume.sh"
  padding_left=10
  icon=$VOLUME_100
  icon.width=0
  icon.align=left
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
  label.width=25
  label.align=left
  label.font="$FONT:Regular:14.0"
  updates=on
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}" \
           --subscribe volume_icon volume_change \
                                   mouse.clicked

sketchybar --add bracket status brew github.bell wifi volume_icon \
           --set status "${status_bracket[@]}"

