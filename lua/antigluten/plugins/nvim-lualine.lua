return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local lazy_status = require("lazy.status")

        require('lualine').setup {
            options = {
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
                theme = 'gruvbox'
            },
            sections = {
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'branch',
                    'diff',
                    'diagnostics'
                },
                lualine_c = {
                    'filename',
                    'buffers',
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    'encoding',
                    'fileformat',
                    'filetype'
                },
                lualine_y = {
                    'progress',
                },
                lualine_z = {
                    'location',
                    'hostname'
                }
            },
        }
    end,
}
