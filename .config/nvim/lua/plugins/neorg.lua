return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.autocommands"] = {},
                ["core.esupports.indent"] = {},
                ["core.concealer"] = {
                    config = {
                        folds = false,
                    }

                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                            cs3210 = "/mnt/drive/Documents/Georgia Tech/CS 3210/notes",
                            cs4262 = "/mnt/drive/Documents/Georgia Tech/CS 4262/notes",
                            econ2105 = "/mnt/drive/Documents/Georgia Tech/ECON 2105/notes",
                        },
                        index = "index.norg",
                    }
                }
            }
        }
    end
}
