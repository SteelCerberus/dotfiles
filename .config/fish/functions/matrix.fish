#!/usr/bin/env fish

function matrix -d "Opens TMatrix with full terminal size"
    kitty @ set-spacing padding=0
    tmatrix $argv
    kitty @ set-spacing padding=default
end
