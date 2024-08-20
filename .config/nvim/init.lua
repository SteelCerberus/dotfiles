-- Have to do these before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'config.options'

-- [[ Basic Keymaps ]]
require 'config.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'config.lazy_bootstrap'

-- [[ Configure and install plugins ]]
require 'config.lazy_plugins'

