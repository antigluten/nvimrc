local preboot_config = function()
    vim.g.zig_fmt_autosave = 0
    vim.g.zig_fmt_parse_errors = 0
    vim.cmd([[autocmd BufWritePre *.zig lua vim.lsp.buf.format()]])
end

local create_configurations = function(capabilities, on_attach)
    local sourcekit_capabilities = capabilities
    local workspace = capabilities.workspace or {}
    workspace.didChangeWatchedFiles = {
        dynamicRegistration = true,
    }
    sourcekit_capabilities.workspace = workspace

    local sourcekit_config = {
        capabilities = sourcekit_capabilities,
        on_attach = on_attach,
        cmd = {
            '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
        },
        root_dir = function(filename, _)
            local util = require('lspconfig.util')
            return util.root_pattern('buildServer.json')(filename)
                or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
                or util.root_pattern('Package.swift')(filename)
                or util.root_pattern('compile_commands.json')(filename)
        end,
    }

    local lua_capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        capabilities
    )
    lua_capabilities.workspace = {
        dynamicRegistration = false,
        library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.expand('$XDG_CONFIG_HOME') .. '/nvim/lua',
        },
    }

    local lua_config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
        end,
        settings = {
            Lua = {
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = 'space',
                        indent_size = '4',
                    },
                },
                type = {
                    castNumberToInteger = true,
                },
                diagnostics = {
                    disable = { 'incomplete-signature-doc', 'trailing-space' },
                    globals = {
                        'vim',
                        'assert',
                        'describe',
                        'it',
                        'before_each',
                        'after_each',
                        'pending',
                        'clear',

                        'G_P',
                        'G_R',
                    },
                    groupSeverity = {
                        strong = 'Warning',
                        strict = 'Warning',
                    },
                    groupFileStatus = {
                        ['ambiguity'] = 'Opened',
                        ['await'] = 'Opened',
                        ['codestyle'] = 'None',
                        ['duplicate'] = 'Opened',
                        ['global'] = 'Opened',
                        ['luadoc'] = 'Opened',
                        ['redefined'] = 'Opened',
                        ['strict'] = 'Opened',
                        ['strong'] = 'Opened',
                        ['type-check'] = 'Opened',
                        ['unbalanced'] = 'Opened',
                        ['unused'] = 'Opened',
                    },
                    unusedLocalExclude = { '_*' },
                },
            },
        },
    }

    local hints = vim.empty_dict()
    hints.assignVariableTypes = true
    hints.compositeLiteralFields = true
    hints.compositeLiteralTypes = true
    hints.constantValues = true
    hints.functionTypeParameters = true
    hints.parameterNames = true
    hints.rangeVariableTypes = true

    local servers = {
        clangd = {},
        sourcekit = sourcekit_config,
        lua_ls = lua_config,
        zls = {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { '/opt/homebrew/bin/zls' },
            settings = {
                zls = {
                    zig_exe_path = '/opt/homebrew/bin/zig',
                },
            },
        },
        ts_ls = {},
        svelte = {},
        pyright = {
            capabilities = capabilities,
            on_attach = on_attach,
        },
        gopls = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                gopls = {
                    gofumpt = true,
                    completeUnimported = true,
                    usePlaceholders = false,
                    diagnosticsDelay = '250ms',
                    staticcheck = true,
                    hints = hints,
                    analyses = {
                        unusedparams = true,
                        framepointer = true,
                        sigchanyzer = true,
                        unreachable = true,
                        stdversion = true,
                        unusedwrite = true,
                        unusedvariable = true,
                        useany = true,
                        nilness = true,
                    },
                },
            },
        },
    }

    return servers
end

local setup_servers = function(lspconfig, servers)
    local lsp = vim.lsp

    local ui = require('config.ui')
    local borders = { border = ui.borders }

    local handlers = {
        ['textDocument/hover'] = lsp.with(lsp.handlers.hover, borders),
        ['txtdocument/signatureHelp'] = lsp.with(
            lsp.handlers.signature_help,
            borders
        ),
    }

    for server, setup in pairs(servers) do
        setup.handlers = handlers
        lspconfig[server].setup(setup)
    end
end

local on_lsp_attach = function()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP Actions',
        callback = function(_)
            local wk = require('which-key')
            wk.add({
                {
                    'K',
                    '<cmd>lua vim.lsp.buf.hover()<cr>',
                    desc = 'LSP hover info',
                },
                {
                    'gd',
                    '<cmd>lua vim.lsp.buf.definition()<cr>',
                    desc = 'LSP go to definition',
                },
                {
                    'gD',
                    '<cmd>lua vim.lsp.buf.declaration()<cr>',
                    desc = 'LSP go to declaration',
                },
                {
                    'gi',
                    '<cmd>lua vim.lsp.buf.implementation()<cr>',
                    desc = 'LSP go to implementation',
                },
                {
                    'gr',
                    '<cmd>lua vim.lsp.buf.references()<crdesc =>',
                    desc = 'LSP list references',
                },
                {
                    'gs',
                    '<cmd>lua vim.lsp.buf.signature_help()<crdesc =>',
                    desc = 'LSP signature help',
                },
                {
                    'gn',
                    '<cmd>lua vim.lsp.buf.rename()<desc =cr>',
                    desc = 'LSP rename',
                },
                {
                    "['[g']",
                    '<cmd>lua vim.diagnostic.goto_prev()<cr>',
                    desc = 'Go to previous diagnostic',
                },
                {
                    "['g]']",
                    '<cmd>lua vim.diagnostic.goto_next()<cr>',
                    desc = 'Go to next diagnostic',
                },
            }, {
                mode = 'n',
                silent = true,
            })
        end,
    })
end

local config = function()
    preboot_config()

    local lspconfig = require('lspconfig')

    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local on_attach = function(_, bufnr)
        local function opts(desc)
            return {
                noremap = true,
                silent = true,
                buffer = bufnr,
                desc = 'LSP ' .. desc,
            }
        end

        local map = vim.keymap.set

        map(
            'n',
            '<leader>d',
            vim.diagnostic.open_float,
            opts('Show line diagnostics')
        )

        map(
            'n',
            'K',
            vim.lsp.buf.hover,
            opts('Show documentation for what is under cursor')
        )

        map(
            'n',
            '<leader>sh',
            vim.lsp.buf.signature_help,
            opts('Show signature help')
        )

        map(
            { 'n', 'v' },
            '<leader>ca',
            vim.lsp.buf.code_action,
            opts('Code action')
        )

        map('n', 'gr', vim.lsp.buf.references, opts('Show references'))
    end

    local servers = create_configurations(capabilities, on_attach)
    setup_servers(lspconfig, servers)

    on_lsp_attach()
end

return {
    {
        'ziglang/zig.vim',
    },
    {
        'neovim/nvim-lspconfig',
        version = '*',
        event = { 'BufReadPre', 'BufNewFile' },
        lazy = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            { 'antosha417/nvim-lsp-file-operations', config = true },
            'ziglang/zig.vim',
        },
        config = config,
    },
}
