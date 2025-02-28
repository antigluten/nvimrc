return {
    'aveplen/ruscmd.nvim',
    'dstein64/vim-startuptime',
    'nvim-lua/plenary.nvim',
    'onsails/lspkind.nvim',
    'sindrets/diffview.nvim',
    { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
    'nvim-tree/nvim-web-devicons',
    {
        'codethread/qmk.nvim',
        opts = {
            name = 'LAYOUT',
            layout = {
                'x x x x x x _ _ _ _ x x x x x x',
                'x x x x x x _ _ _ _ x x x x x x',
                'x x x x x x _ _ _ _ x x x x x x',
                'x x x x x x x _ _ x x x x x x x',
                'x _ _ x x x x _ _ x x x x _ _ x',
            },
        },
    },
    {
        'VPavliashvili/json-nvim',
        ft = 'json', -- only load for json filetype
    },
    {
        'm4xshen/hardtime.nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        opts = {},
        enabled = false,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            exclude_ft = { 'oil' },
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'echasnovski/mini.hipatterns',
        version = false,
        config = function()
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme = {
                        pattern = '%f[%w]()FIXME()%f[%W]',
                        group = 'MiniHipatternsFixme',
                    },
                    hack = {
                        pattern = '%f[%w]()HACK()%f[%W]',
                        group = 'MiniHipatternsHack',
                    },
                    todo = {
                        pattern = '%f[%w]()TODO()%f[%W]',
                        group = 'MiniHipatternsTodo',
                    },
                    note = {
                        pattern = '%f[%w]()NOTE()%f[%W]',
                        group = 'MiniHipatternsNote',
                    },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
}
