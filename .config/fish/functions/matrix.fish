#!/usr/bin/env fish

function matrix -d "Opens CMatrix with full terminal size"
    kitty @ set-spacing padding=0
    tmatrix --background=default --title=" " $argv
    kitty @ set-spacing padding=default
end
