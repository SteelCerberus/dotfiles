#!/usr/bin/env fish

# Custom prompt using Oh My Posh
oh-my-posh init fish --config ~/.config/fish/prompt.omp.json | source
#starship init fish | source

# Add to path
fish_add_path ~/.local/bin
fish_add_path ~/go/bin

# Use nvim for reading man pages
set -x MANPAGER "nvim +Man!"

# Use nvim as editor
set VISUAL nvim
set EDITOR nvim
set OPENER nvim

# Use vi mode
fish_vi_key_bindings

# Aliases
alias ls='eza --color=always --group-directories-first --icons always'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -al --color=always --group-directories-first'

alias ..='cd ..'
alias ...='cd ../..'

