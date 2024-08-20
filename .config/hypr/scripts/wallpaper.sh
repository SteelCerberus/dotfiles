#!/bin/bash
dir=./wallpapers

active=$(hyprctl hyprpaper listactive)
current_bg=$(basename "${active##* }")

rand=$(ls $dir -I $current_bg | shuf -n 1)
hyprctl hyprpaper unload all -q
hyprctl hyprpaper preload $dir/$rand -q
hyprctl hyprpaper wallpaper ", $dir/$rand" -q

