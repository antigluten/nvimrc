return {
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            require('catppuccin').setup({
                show_end_of_buffer = true,
                term_colors = true,
            })
            vim.cmd([[colorscheme catppuccin]])
        end
    }
}
