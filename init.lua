-- package.path = package.path .. "~/.luarocks/share/lua/5.1/magick/init.lua;"

local rocks_config = {
    rocks_path = "/Users/va-gusev/.local/share/nvim/rocks",
    luarocks_binary = "/Users/va-gusev/.local/share/nvim/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))

require('antigluten.core')
-- require('antigluten.lazy')

vim.opt.guicursor = ""
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"

vim.opt.background = "dark"
vim.cmd([[set nofoldenable]])
vim.opt.termguicolors = true
