return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  config = function()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {},
        ["core.highlights"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.autocommands"] = {},
        ["core.esupports.indent"] = {},
        ["core.summary"] = {},
        ["core.export"] = {},
        ["core.concealer"] = {
          config = {
            folds = false,
            icon_preset = "basic",
          }

        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              cs3210 = "~/gateh/cs3210",
              cs4262 = "~/gatech/cs4262",
              econ2105 = "~/gatech/econ2105",
            },
            index = "index.norg",
          }
        }
      }
    }
  end
}
