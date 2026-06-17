local ensureInstalled = {
  "bash",
  "c",
  "diff",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "vim",
  "python",
  "query",
  "regex",
  "toml",
  "java",
  "yaml",
  "ruby",
  "go",
  "css",
  "typescript",
  "javascript",
  "json",
  "jsdoc",
  "json5",
  "rust",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    -- Modern way: pass configurations directly to opts
    opts = {
      ensure_installed = ensureInstalled,
      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },
    },
    -- Use the config function ONLY for your custom autocmds and extra tools
    -- config = function(_, opts)
    --   -- Initialize treesitter with the clean opts table above
    --   require("nvim-treesitter.configs").setup(opts)
    --
    --   -- The comments parser and LSP highlights block
    --   vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    --     desc = "User: highlights for the Treesitter `comments` parser",
    --     callback = function()
    --       vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
    --       vim.api.nvim_set_hl(0, "@comment.bold", { bold = true })
    --     end,
    --   })
    --
    --   -- Modern ts_query_ls server configuration
    --   local tsDir = require("nvim-treesitter.config").get_install_dir("parser")
    --   if tsDir and vim.lsp.config then
    --     vim.lsp.config("ts_query_ls", {
    --       init_options = { parser_install_directories = { tsDir } },
    --     })
    --   end
    -- end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.g.no_plugin_maps = true
    end,
  },
}
