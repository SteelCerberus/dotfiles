#!/usr/bin/env fish

function d -d "Change directory and ls"
    cd $argv
    eza --color=always --group-directories-first --icons always
end
