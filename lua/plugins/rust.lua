return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                executor = 'toggleterm',
                replace_builtin_hover = false,
                float_win_config = {
                    border = 'rounded',
                },
            },
            server = {
                on_attach = function()
                    vim.keymap.set('n', '<leader>c', function()
                        vim.cmd.RustLsp('codeAction')
                    end, { silent = true, buffer = true })
                end,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        inlayHints = {
                            lifetimeElisionHints = {
                                enable = true,
                                useParameterNames = true,
                            },
                        },
                    },
                },
            },
            dap = {},
        }
    end,
}
