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
