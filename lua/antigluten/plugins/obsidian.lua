return {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {

    },
    config = function()
        require("obsidian").setup {
            workspaces = {
                {
                    name = "Vladimir's Hub",
                    path = "~/Vladimir's Hub"
                },
            },
            daily_notes = {
                folder = "Daily Notes",
                date_format = "%Y-%m-%d",
                template = nil,
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
        }
    end,
}
