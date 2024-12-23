return {
  "nvim-telescope/telescope.nvim",
  dependencies = {"nvim-lua/plenary.nvim", {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  }},

  config = function(_)
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    })

    require("telescope").load_extension("fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>f", builtin.find_files, {})
    vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>l", builtin.lsp_document_symbols, {})
  end,
}
