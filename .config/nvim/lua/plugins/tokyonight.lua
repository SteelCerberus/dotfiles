return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    require("tokyonight").setup({
      on_highlights = function(hl, c)
        -- Use :Inspect while hovered over an element to see its name
        -- hl["@lsp.type.property"] = { fg = "#73daca" }
        -- hl["@lsp.type.variable"] = { fg = "#7dcfff" }
        -- hl["@lsp.type.macro"] = { fg = "#2ac3de" }
        hl["@lsp.type.variable"] = { fg = "#7aa2f7" }
      end
    })
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
