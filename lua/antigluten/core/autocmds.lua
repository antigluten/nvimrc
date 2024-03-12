local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("SetFileTypes", { clear = true })

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
