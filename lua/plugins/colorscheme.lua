return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        lazy = false,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                transparent_background = false,
                dim_inactive = {
                    enabled = false,
                    shade = 'light',
                    percentage = 0.9,
                },
                integrations = {
                    aerial = true,
                    dap = true,
                    dap_ui = true,
                    notify = true,
                    which_key = true,
                },
                custom_highlights = function(colors)
                    local searchActive = { bg = colors.red, fg = '#181825' }
                    local searchInactive = { bg = colors.peach, fg = '#000000' }

                    return {
                        CursorLineNr = { fg = colors.flamingo },
                        Search = searchInactive,
                        IncSearch = searchActive,
                        EndOfBuffer = { fg = colors.flamingo },
                        WinSeparator = {
                            fg = colors.mantle,
                            bg = colors.mantle,
                        },
                    }
                end,
            })

            vim.cmd.colorscheme('catppuccin')
        end,
    },
}
