local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.mouse = 'a'  -- set to 'a' for mouse, '' for no mouse

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
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.signcolumn = 'yes:1'

-- Show whitespace
opt.list = true
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
-- Alternatively, tab = '» '

-- Changes the ~ at the end of the file to spaces
opt.fillchars = { eob = " " }


local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    require("lazy").update({
      show = false,
    })
  end,
})
