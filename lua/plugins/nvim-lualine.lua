local function xcodebuild_device()
    if vim.g.xcodebuild_platform == 'macOS' then
        return ' macOS'
    end

    local deviceIcon = ''
    if vim.g.xcodebuild_platform:match('watch') then
        deviceIcon = '􀟤'
    elseif vim.g.xcodebuild_platform:match('tv') then
        deviceIcon = '􀡴 '
    elseif vim.g.xcodebuild_platform:match('vision') then
        deviceIcon = '􁎖 '
    end

    if vim.g.xcodebuild_os then
        return deviceIcon
            .. ' '
            .. vim.g.xcodebuild_device_name
            .. ' ('
            .. vim.g.xcodebuild_os
            .. ')'
    end

    return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local lazy_status = require('lazy.status')

        require('lualine').setup({
            options = {
                theme = 'auto',
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'branch',
                    'diff',
                    'diagnostics',
                },
                -- lualine_c = {
                --     'filename',
                --     'buffers',
                -- },
                lualine_x = {
                    {
                        "' ' .. vim.g.xcodebuild_last_status",
                        color = { fg = 'Gray' },
                    },
                    {
                        "'󰙨 ' .. vim.g.xcodebuild_test_plan",
                        color = { fg = '#a6e3a1', bg = '#161622' },
                    },
                    {
                        xcodebuild_device,
                        color = { fg = '#f9e2af', bg = '#161622' },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = '#ff9e64' },
                    },
                    'encoding',
                    'fileformat',
                    'filetype',
                },
                lualine_y = {
                    'progress',
                },
                lualine_z = {
                    'location',
                    'hostname',
                },
            },
        })
    end,
}
