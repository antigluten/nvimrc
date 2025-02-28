return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = function(_, opts)
        opts.debug = true
        opts.runtime = '~/Developer/neovim/runtime/'
    end,
}
