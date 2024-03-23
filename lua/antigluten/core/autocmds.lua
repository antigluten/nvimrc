local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- FileTypes

augroup("SetFileTypes", { clear = true })
autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = {'*.h', '*.cpp', '*.CC', '*.c++', '*.def'},
  command = 'setlocal ft=cpp',
})

autocmd({'Bufread', 'Bufnewfile'}, {
    group = 'SetFileTypes',
    pattern = {'*.mm'},
    command = 'setlocal ft=objcpp',
})

autocmd({'Bufread', 'Bufnewfile'}, {
    group = 'SetFileTypes',
    pattern = {'*.swift'},
    command = 'setlocal ft=swift',
})

-- Resize Window

augroup('ResizeWindow', { clear = true })
autocmd('VimResized', {
    group = 'ResizeWindow',
    command = 'wincmd =',
})

-- Buffer Behaviours

augroup('BufferBehaviour', { clear = true })
autocmd({'BufWritePost'}, {
  group = 'BufferBehaviour',
  pattern = {'*.snippets'},
  command = "<cmd>CmpUltisnipsReloadSnippets",
})
