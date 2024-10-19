return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.move').setup()

      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        n_lines = 500,
        custom_textobjects = {
          a = spec_treesitter { a = '@parameter.outer', i = '@parameter.inner' },
          c = spec_treesitter { a = '@class.outer', i = '@class.inner' },
          f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
          F = spec_treesitter { a = '@call.outer', i = '@call.inner' },
          o = spec_treesitter {
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
        }
    })
    end,
}
