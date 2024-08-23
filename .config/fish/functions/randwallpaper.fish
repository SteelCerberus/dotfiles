#!/usr/bin/env fish

function randwallpaper -d "Selects a random wallpaper in the given directory"
    set -l dir $argv[1]
    set -l active $(hyprctl hyprpaper listactive)
    set -l active_path $(echo $active | cut -d ' ' -f 3)
    set -l active_file $(basename $active)

    set -l potentials $(find $dir -type f -not -name $active_file)
    set -l rand $(random choice $potentials)
    echo $rand

    hyprctl hyprpaper unload all -q
    hyprctl hyprpaper preload $rand -q
    hyprctl hyprpaper wallpaper ",$rand" -q
end

