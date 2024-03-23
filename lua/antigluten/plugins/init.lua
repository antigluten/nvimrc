return {
    "nvim-lua/plenary.nvim",
    'onsails/lspkind.nvim',
    'https://github.com/apple/pkl-neovim.git',
    'philj56/vim-asm-indent',
    {
        dir = "~/Developer/lua/plugins/antigluten.nvim",
        config = function()
            require('plugin').setup {
                ["core"] = {

                },
                ["ui"] = {
                    float = false,
                },
            }
        end,
    }
}
