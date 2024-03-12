local opt = vim.opt

vim.wo.number = true

vim.opt.title = true

opt.splitright = true
opt.splitbelow = true

opt.clipboard = 'unnamedplus'
opt.fixeol = false
opt.completeopt = 'menuone,noselect'

-- Не автокомментировать новые линии при переходе на новую строку
vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.expandtab = true
-- opt.scrolloff = 10
opt.laststatus = 2

opt.mouse = 'a'

opt.breakindent = true
opt.wrap = true
opt.path:append { '**' }

vim.wo.conceallevel = 2

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
-- vim.opt.termguicolors = true
