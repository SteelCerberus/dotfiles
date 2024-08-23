#!/usr/bin/env fish

function changewallpaper -d "Changes wallpaper"
    set -l file $(realpath $argv[1])
    hyprctl hyprpaper unload all -q
    hyprctl hyprpaper preload $file -q
    hyprctl hyprpaper wallpaper ",$file" -q
end

