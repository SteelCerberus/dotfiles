return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  config = function()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
              cs3210 = "/mnt/drive/Documents/Georgia Tech/CS 3210/notes",
              cs4262 = "/mnt/drive/Documents/Georgia Tech/CS 4262/notes",
            },
            index = "index.norg",
          }
        }
      }
    }
  end
}
