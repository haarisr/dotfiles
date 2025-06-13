#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper unload "$CURRENT_WALL" > /dev/null
hyprctl hyprpaper preload "$WALLPAPER" > /dev/null
hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER" > /dev/null
