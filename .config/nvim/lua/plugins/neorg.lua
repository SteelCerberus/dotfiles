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
              cs3210 = "~/gatech/cs3210",
              cs4262 = "~/gatech/cs4262",
              econ2105 = "~/gatech/econ2105",
              econ2106 = "~/gatech/econ2106",
              cs4240 = "~/gatech/cs4240",
              cs3220 = "~/gatech/cs3220",
              cs3235 = "~/gatech/cs3235",
              lmc3403 = "~/gatech/lmc3403",
              cs4210 = "~/gatech/cs4210",
              cs3510 = "~/gatech/cs3510",
            },
            index = "index.norg",
          }
        }
      }
    }
  end
}
