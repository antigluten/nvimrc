return { 
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension "file_browser"
        end,
    },
    {
        'nvim-telescope/telescope-media-files.nvim',
        config = function() 
            require('telescope').load_extension('media_files')
            require('telescope').setup {
                extensions = {
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = {"png", "webp", "jpg", "jpeg"},
                        -- find command (defaults to `fd`)
                        find_cmd = "rg"
                    }
                },
            }
        end,
    }
}
