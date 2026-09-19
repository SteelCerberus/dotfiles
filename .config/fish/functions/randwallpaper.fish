#!/usr/bin/env fish

function randwallpaper -d "Selects a random wallpaper in the given directory"
    set -l dir $argv[1]

    # Extract active wallpaper path
    set -l active_path (hyprctl hyprpaper listactive | string match -r '/.*' | head -n 1)

    # Get all files and exclude the exact active path literally (-F)
    set -l potentials (find $dir -type f | grep -Fv "$active_path")

    if test (count $potentials) -eq 0
        echo "No alternative wallpapers found in $dir"
        return 1
    end

    set -l rand (random choice $potentials)
    echo $rand

    hyprctl hyprpaper unload all -q
    hyprctl hyprpaper preload $rand -q
    hyprctl hyprpaper wallpaper ",$rand" -q
end
