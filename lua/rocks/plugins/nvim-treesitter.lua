local opts = {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "make",
        -- "llvm",
        -- "json",
        "vim",
        -- "vimdoc",
        -- "nasm",
        -- "swift",
        -- "objc",
        -- "rust",
    },
    matchup = { enable = true, },
    highlight = { enable = true, },
    sync_install = false,
    auto_install = true,
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold" },
    },
    indent = true,
}

require("nvim-treesitter.configs").setup(opts)
