#!/bin/sh

# hangul and english item

# Read the plist data
plist_data=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)
current_input_source=$(echo "$plist_data" | plutil -convert xml1 -o - - | grep -A1 'KeyboardLayout Name' | tail -n1 | cut -d '>' -f2 | cut -d '<' -f1)

case "$current_input_source" in
    "ABC")
        sketchybar --set input_source icon="EN"
        ;;
    "USInternational-PC")
        sketchybar --set input_source icon="US"
        ;;
    "Korean")
        sketchybar --set input_source icon="KR"
        ;;
    *)
        # For any other layout, show first 2 characters
        layout_short=$(echo "$current_input_source" | cut -c1-2)
        sketchybar --set input_source icon="$layout_short"
        ;;
esac
