#!/usr/bin/env fish

function lt -d "List in a tree. Defaults to a depth of 2. If a number, the first argument will be used as depth; e.g., 'lt 3 -a' shows all files to a depth of 3."
    if test (count $argv) -eq 0
        eza --color=always --group-directories-first --icons always -T --level 2
        return 0
    else
        set -f num $argv[1]
    end

    # Check if the argument is a number using regex
    if string match --quiet --regex '^[0-9]+$' $num
        eza --color=always --group-directories-first --icons always -T --level $num $argv[2..-1]
    else
        eza --color=always --group-directories-first --icons always -T --level 2 $argv
    end
end
