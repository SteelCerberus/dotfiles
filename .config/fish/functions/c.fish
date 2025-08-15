#!/usr/bin/env fish

function c -d "Clear the screen and display fastfetch"
    clear
    kitten icat -n --place 19x19@0x0 --scale-up --align left "$HOME/.config/fastfetch/logos/cachy1.png" | fastfetch --logo-width 20 -c "$HOME/.config/fastfetch/config_small.jsonc" --raw -
end

