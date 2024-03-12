package.path = package.path .. "~/.luarocks/share/lua/5.1/magick/init.lua;"

require('antigluten.core')
require('antigluten.lazy')

vim.opt.guicursor = ""
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"

vim.opt.background = "dark"
vim.cmd([[set nofoldenable]])
vim.opt.termguicolors = true
