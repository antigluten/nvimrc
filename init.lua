-- package.path = package.path .. "~/.luarocks/share/lua/5.1/magick/init.lua;"

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

require('langmapper').automapping({ global = true, buffer = true })

local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
    -- | `to` should be first     | `from` should be second
    escape(ru_shift) .. ';' .. escape(en_shift),
    escape(ru) .. ';' .. escape(en),
}, ',')
