return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        -- Latest stable release is v7.0.0
        -- To use it, we should provide version with `version`
        -- If I wanna use my customized Neorg,
        -- I have to provide dir path
        -- `~/Developer/lua/plugins/neorg`
        -- 
        -- Neorg has migrated to luarocks
        -- 
        -- >= v8.0.0 doesn't use build setting
        -- `build = ":Neorg sync-parsers"`
        "nvim-neorg/neorg",
        version = "*",
        lazy = false,
        dependencies = {
            "luarocks.nvim"
        },
        ft = "norg",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond"
                        },
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            use_popup = false,
                            inject_metadata = true
                        },
                    },
                    ["core.keybinds"] = {
                        config = {
                            hook = function (keybinds)
                                keybinds.remap_event("norg", "n", "<C-n>", "core.dirman.new.note")
                            end,
                        }
                    },
                    ["core.esupports.metagen"] = {
                        config = {
                            author = "Vladimir Gusev",
                        },
                    },
                },
            }
        end,
    }
}
