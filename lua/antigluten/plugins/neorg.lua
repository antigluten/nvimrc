return {
    dir = "~/Developer/lua/plugins/neorg",
    build = ":Neorg sync-parsers",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "norg",
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond"
                    },
                }, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    use_popup = false,
                    inject_metadata = true
                },
            },
            ["core.keybinds"] = {
                -- default_keybinds = true,
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
