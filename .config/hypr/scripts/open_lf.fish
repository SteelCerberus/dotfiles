#!/usr/bin/env fish

set -l clip "$(wl-paste)"

if test -f "$clip"
  # Opens the file in kitty in a detached terminal (so killing the parent process won't kill it). Hold makes it so exiting neovim won't close the terminal. 
  set -l filedir $(dirname "$clip")
  kitty --directory $filedir --hold --detach fish -c "l"
else if test -d "$clip"
    # If a directory, just open kitty in that directory
    kitty --directory "$clip" --hold --detach fish -c "l"
end

