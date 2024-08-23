#!/usr/bin/env fish

function draw
  kitty +kitten icat --silent --stdin no --transfer-mode file --place $w'x'$h'@'$x'x'$y "$argv[1]" </dev/null >/dev/tty
  exit 1
end

set file $argv[1]
set w $argv[2]
set h $argv[3]
set x $argv[4]
set y $argv[5]

switch (file -Lb --mime-type $file)
case "image/*"
    draw $file
case '*'
    pistol $file
end

