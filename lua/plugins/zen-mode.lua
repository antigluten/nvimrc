return {
    {
        'folke/zen-mode.nvim',
        opts = {
            window = {
                width = 0.90,
                options = {
                    relativenumber = false,
                    number = false,
                },
            },
            plugins = {
                kitty = {
                    enabled = true,
                    font = '24',
                },
            },
        },
    },
    { 'folke/twilight.nvim' },
}
