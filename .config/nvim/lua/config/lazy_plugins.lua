-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import plugins
    { import = "plugins" },
  },
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

