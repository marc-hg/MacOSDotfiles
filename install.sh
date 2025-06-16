#!/bin/bash

# Dotfiles installer script
# This script creates symlinks from ~/.config to the dotfiles repo

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Installing dotfiles..."

# Function to backup and symlink
backup_and_link() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to $target.bak"
        mv "$target" "$target.bak"
    elif [ -L "$target" ]; then
        echo "Removing existing symlink $target"
        rm "$target"
    fi
    
    echo "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Create ~/.config if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Symlink aerospace config
backup_and_link "$DOTFILES_DIR/aerospace" "$CONFIG_DIR/aerospace"

# Symlink sketchybar config
backup_and_link "$DOTFILES_DIR/sketchybar" "$CONFIG_DIR/sketchybar"

echo "Done! Your configs are now symlinked to the dotfiles repo."
echo "You can now commit and push your dotfiles:"
echo "  cd $DOTFILES_DIR"
echo "  git add ."
echo "  git commit -m 'Initial dotfiles commit'"
echo "  git remote add origin <your-repo-url>"
echo "  git push -u origin main" 