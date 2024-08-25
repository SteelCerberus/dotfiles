local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.mouse = ''  -- don't want mouse

-- Doesn't show mode in status bar
opt.showmode = false

vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Saves undo history
opt.undofile = true

-- Editing
opt.ignorecase  = true -- Ignore case when searching (use `\C` to force not doing that)
opt.incsearch   = true -- Show search results while typing
opt.infercase   = true -- Infer letter cases for a richer built-in keyword completion
opt.smartcase   = true -- Don't ignore case when searching if pattern has upper case

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Show whitespace
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Changes the ~ at the end of the file to spaces
opt.fillchars = { eob = " " }
