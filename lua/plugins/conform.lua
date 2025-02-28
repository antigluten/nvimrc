return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        formatters_by_ft = {
            bash = { 'shfmt', 'shellcheck' },
            c = { 'clang-format' },
            cpp = { 'clang-format' },
            go = { 'golines', 'goimports', 'gofmt', 'gofumpt', 'gci' },
            lua = { 'stylua' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            -- swift = { 'swiftformat' },
            zsh = { 'shfmt', 'shellcheck' },
        },
        format_on_save = function()
            return { timeout_ms = 500, lsp_fallback = true }
        end,
        log_level = vim.log.levels.DEBUG,
    },
}
