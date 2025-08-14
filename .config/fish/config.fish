#!/usr/bin/env fish

# Custom prompt using Oh My Posh
oh-my-posh init fish --config ~/.config/fish/prompt.omp.json | source

# Use nvim for reading man pages
set -gx MANPAGER "nvim +Man!"

# Use nvim as editor
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx OPENER nvim

# Disable the (venv) before the prompt. Using a custom oh-my-posh module for this.
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# Use vi mode
fish_vi_key_bindings

# Aliases
alias ls='eza --color=always --group-directories-first --icons always'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -al --color=always --group-directories-first'

alias ..='cd ..'
alias ...='cd ../..'

