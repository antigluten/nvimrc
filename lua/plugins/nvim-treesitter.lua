return {
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = { mode = 'cursor' },
        enabled = true,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        version = false,
        cmd = { 'TSUpdateSync' },
        opts = {
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'make',
                'llvm',
                'json',
                'vim',
                'vimdoc',
                'nasm',
                'swift',
                'objc',
                'rust',
            },
            matchup = { enable = true },
            highlight = { enable = true, use_languagetree = true },
            sync_install = false,
            auto_install = true,
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { 'BufWrite', 'CursorHold' },
            },
            indent = true,
        },
        config = function(_, opts)
            require('nvim-treesitter.install').compilers = { 'gcc' }
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
