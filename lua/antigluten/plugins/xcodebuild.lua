return {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    config = function()
        require("xcodebuild").setup({
            logs = {
                logs_formatter = nil,
            },
            code_coverage = {
                enabled = true,
            },
        })
    end,
}
