return {
    {
        "sirver/ultisnips",
        lazy=false,
        init = function()
            vim.g.UltiSnipsSnippetsDir = vim.env.HOME .. "/.config/nvim/ulti-snippets"
            vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. "/.config/nvim/ulti-snippets", }
            vim.g.UltiSnipsExpandTrigger = "<tab>"
            vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
            vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
        end
    },
    {
        "prabirshrestha/asyncomplete-ultisnips.vim",
        lazy=false
    },
}
