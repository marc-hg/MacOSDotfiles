#!/bin/bash

# Function to move app to workspace if running, otherwise open it
organize_app() {
    local app_name="$1"
    local workspace="$2"
    local bundle_id="$3"
    
    # Always try to open the app first (if already running, macOS will just focus it)
    open -a "$app_name"
    
    # Wait a moment for the app to be ready
    sleep 1
    
    # Simple approach: get window IDs and move them  
    /opt/homebrew/bin/aerospace list-windows --monitor all --app-id "$bundle_id" --format "%{window-id}" | while read window_id; do
        if [ -n "$window_id" ]; then
            echo "Moving $app_name window $window_id to workspace $workspace"
            /opt/homebrew/bin/aerospace move-node-to-workspace "$workspace" --window-id "$window_id"
        fi
    done
}

# Organize each app
organize_app "Arc" 3 "company.thebrowser.Browser"
organize_app "Slack" 4 "com.tinyspeck.slackmacgap"  
organize_app "Obsidian" 10 "md.obsidian"
organize_app "iTerm" 1 "com.googlecode.iterm2"
organize_app "Rider" 2 "com.jetbrains.rider"
organize_app "Cursor" 2 "com.todesktop.230313mzl4w4u92" 