# !/usr/bin/env fish

function cyclewallpaper -d "Cycles to the next wallpaper in the given directory"
    set -l dir $argv[1]

    # Get all wallapers sorted alphabetically
    set -l files (find $dir -type f -exec realpath {} \; | sort)
    set -l total (count $files)

    if test $total -eq 0
        echo "No wallpapers found in $dir"
        return 1
    end

    # Extract active wallpaper path
    set -l active_path (hyprctl hyprpaper listactive | string match -r '/.*' | head -n 1)

    # Default to the first image if active path is not set or found
    set -l next_idx 1

    # Find current active index and calculate next index
    if test -n "$active_path"
        set -l current_idx (contains -i -- "$active_path" $files)
        if test -n "$current_idx"
            set next_idx (math "($current_idx % $total) + 1")
        end
    end

    set -l next_wallpaper $files[$next_idx]
    echo $next_wallpaper

    # hyprctl hyprpaper unload all -q
    # hyprctl hyprpaper preload $next_wallpaper -q
    # hyprctl hyprpaper wallpaper ",$next_wallpaper" -q
    waypaper --wallpaper $next_wallpaper
end

