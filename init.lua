
require('antigluten.core')
require('antigluten.lazy')

vim.opt.guicursor = ""
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"

vim.opt.background = "dark"
vim.cmd([[set nofoldenable]])
-- vim.opt.termguicolors = true

-- TODO: twilight/zen-mode overrides fold settings and enable it
-- https://www.reddit.com/r/neovim/comments/uelrd7/need_some_help_with_lua_autocmd/
vim.cmd([[
autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99
]])
