return {
    '3rd/image.nvim',
    enabled = true,
    config = function()
        require('image').setup {
            backend = 'kitty',
            integrations = {
                markdown = {
                    enabled = true,
                    only_render_image_at_cursor = true,
                    filetypes = { 'markdown', 'vimwiki', 'quarto' },
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil, -- 100
            max_height = nil, -- 15
            max_width_window_percentage = nil,
            max_height_window_percentage = 20,

            window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            -- auto show/hide images when the editor gains/looses focus
            editor_only_render_when_focused = false,
            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            tmux_show_only_in_active_window = false,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        }
    end,
}
