local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

---comment
---@param group table
---@param event table|string
---@param pattern table
---@param command string
local function register_command(group, event, pattern, command)
    create_augroup(group.name, { clear = group.clear })
    create_autocmd(event, {
        group = group.name,
        pattern = pattern,
        command = command,
    })
end

local function register_commands(params)
    for _, value in ipairs(params) do
        register_command(value.group, value.event, value.pattern, value.command)
    end
end

local autocmds = {
    {
        group = {
            name = 'SetFileTypes',
            clear = true,
        },
        event = { 'Bufread', 'Bufnewfile' },
        pattern = { '*.h', '*.cpp', '*.CC', '*.c++', '*.def' },
        command = 'setlocal ft=cpp',
    },
    {
        group = {
            name = 'ResizeWindow',
            clear = true,
        },
        event = 'VimResized',
        command = 'wincmd =',
    },
    {
        group = {
            name = 'BufferBehaviour',
            clear = true,
        },
        event = 'BufWritePost',
        pattern = { '*.snippets' },
        command = '<cmd>CmpUltisnipsReloadSnippets',
    },
}

register_commands(autocmds)

create_autocmd({ 'Bufread', 'Bufnewfile' }, {
    group = 'SetFileTypes',
    pattern = { '*.mm' },
    command = 'setlocal ft=objcpp',
})

create_autocmd({ 'Bufread', 'Bufnewfile' }, {
    group = 'SetFileTypes',
    pattern = { '*.swift' },
    command = 'setlocal ft=swift',
})

create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
        require('conform').format({ bufnr = args.buf })
    end,
})
