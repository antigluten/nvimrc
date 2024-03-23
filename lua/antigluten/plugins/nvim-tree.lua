return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
            -- vim.keymap.set('n', '<C-n>', api.tree.toggle, opts('Tree'))
            vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                side = "right",
                width = 50,
                number = false,
                float = {
                    enable = false,
                },
            },
            renderer = {
                group_empty = true,
                highlight_git = "none", -- "name"
                indent_markers = {
                    enable = true,
                    inline_arrows = false,
                }
            },
            filters = {
                dotfiles = false,
            },
        })
    end
}
