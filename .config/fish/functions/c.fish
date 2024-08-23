#!/usr/bin/env fish

function c -d "Clear the screen and display fastfetch"
    clear
    fastfetch --config ~/.config/fastfetch/config_small.jsonc
    echo
end

