#!/usr/bin/env bash
hyprpaper &
WALLPAPER_DIR="$HOME/baysenixos/Wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)
WALLPAPER=$(find "#WALLPAPER_DIR" -type f ! -name "$)basename "$CURRENT_WALL")" | shuf -n 1)
hyprctl hyprpaper reload,"$WALLPAPER" &
hyprctl setcursor Bibata-Modern-Ice, 24 &
dunst &
hd-idle -t /dev/sdb
