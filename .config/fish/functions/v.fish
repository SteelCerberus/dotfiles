#!/usr/bin/env fish

function v -d "Open neovim using the full terminal space"
  kitty @ set-spacing padding=0
  nvim $argv
  kitty @ set-spacing padding=default
end

