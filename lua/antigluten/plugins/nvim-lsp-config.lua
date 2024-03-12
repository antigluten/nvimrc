return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()
        local opts = { noremap = true, silent = true }
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            opts.desc = "Show line diagnostics"
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Show documentation for what is under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        end

        lspconfig["sourcekit"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "/Applications/Xcode-15.2.0.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
            },
            root_dir = function(filename, _)
                return util.root_pattern("buildServer.json")(filename)
                    or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
                    or util.find_git_ancestor(filename)
                    or util.root_pattern("Package.swift")(filename)
            end,
        })

        local ui = require('antigluten.setup.ui')
        local borders = { border = ui.borders }
        local lsp = vim.lsp

        local handlers = {
            ["textDocument/hover"] = lsp.with(lsp.handlers.hover, borders),
            ["txtdocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, borders),
        }
        
        local servers = {
            clangd = {},
            sourcekit = {
                root_dir = lspconfig.util.root_pattern(
                    '.git',
                    'Package.swift',
                    'compile_commands.json'
                ),
            },
            lspconfig.rust_analyzer.setup {}
        }

        for server, setup in pairs(servers) do
            setup.handlers = handlers
            lspconfig[server].setup(setup)
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP Actions',
            callback = function(args)
                -- Once we've attached, configure the keybindings
                local wk = require('which-key')
                wk.register({
                    K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "LSP hover info"},
                    gd = {"<cmd>lua vim.lsp.buf.definition()<cr>", "LSP go to definition"},
                    gD = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP go to declaration"},
                    gi = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP go to implementation"},
                    gr = {"<cmd>lua vim.lsp.buf.references()<cr>", "LSP list references"},
                    gs = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "LSP signature help"},
                    gn = {"<cmd>lua vim.lsp.buf.rename()<cr>", "LSP rename"},
                    ["[g"] = {"<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic"},
                    ["g]"] = {"<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic"},
                }, {
                        mode = 'n',
                        -- buffer = true,
                        silent = true,
                    })
            end,
     })
    end,
}
