return {
    "nvim-lua/plenary.nvim",
    'onsails/lspkind.nvim',
    'https://github.com/apple/pkl-neovim.git',
--    'https://github.com/apple/pkl-neovim.git',
    'philj56/vim-asm-indent',
    'dstein64/vim-startuptime',
    {
        'Wansmer/langmapper.nvim',
        lazy = false,
        priority = 1, -- High priority is needed if you will use `autoremap()`
        config = function()
            require('langmapper').setup({--[[ your config ]]})
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    }
}
