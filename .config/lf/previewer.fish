#!/usr/bin/env fish

set file $argv[1]
set w $argv[2]
set h $argv[3]
set x $argv[4]
set y $argv[5]

set line "$lf_user_preview_offset"

switch (file -Lb --mime-type $file)
case "image/*"
    kitten icat --silent --stdin no --transfer-mode memory --place $w'x'$h'@'$x'x'$y "$file" </dev/null >/dev/tty
case '*'
    set center $(math --scale 0 "($LINES - 3) / 2")
    if test $line -lt $center
        set center $line
    end
    set start $(math "$line - $center")
    set end $(math "$start + $LINES")
    bat --color always --highlight-line "$line" --line-range "$start:$end" --paging always "$file"
end

exit 1

