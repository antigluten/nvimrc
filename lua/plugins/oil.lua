return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Oil' },
    keys = {
        { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
    opts = {
        float = {
            max_width = 80,
        },
        watch_for_changes = true,
        delete_to_trash = true,
        columns = {
            { 'icon', add_padding = false },
        },
        view_options = {
            show_hidden = true,
        },
    },
}
