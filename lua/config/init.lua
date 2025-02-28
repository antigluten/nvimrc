_G.config = {}

local opt = vim.opt
local wo = vim.wo
local global_scope = vim.g

---Macro for setting a global mapping
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
local function map(mode, lhs, rhs, opts)
    local keymap = vim.api.nvim_set_keymap
    keymap(mode, lhs, rhs, opts or {})
end

---Sets provided options for selected scope
---@param scope table
---@param opts table
local function set_options(scope, opts)
    local options = opts or {}
    if next(options) == nil then
        return
    end
    for key, value in pairs(options) do
        scope[key] = value
    end
end

local map_options = { noremap = true, silent = true }

local normal_mappings = {
    -- { "<leader>n", ":NvimTreeToggle<CR>" },
    -- { "<leader>ff", ":NvimTreeFindFile<CR>" },
    { '<leader>zm', ':ZenMode<CR>' },
    -- { '-', '<CMD>Oil<CR>' },
    { '<A-,>', '<Cmd>BufferPrevious<CR>' },
    { '<A-.>', '<Cmd>BufferNext<CR>' },
    { '<leader>nt', ':Neorg toc<CR>' },
}

local function setup_mappings()
    for _, value in ipairs(normal_mappings) do
        local lhs = value[1]
        local rhs = value[2]
        map('n', lhs, rhs, map_options)
    end
end

---@class Config: Options
local M = {}

---vim.scriptencoding = 'utf-8'

---@class Options
local defaults = {
    ---@type string|fun()
    colorscheme = function()
        vim.cmd([[colorscheme moonfly]])
        -- require("moonfly").load()
    end,
    options = {
        -- lazyredraw = true,
        encoding = 'utf-8',
        fileencoding = 'utf-8',
        cursorline = true,
        winblend = 0,
        wildoptions = 'pum',
        pumblend = 5,
        background = 'dark',
        -- background = 'dark',
        --background = "light",
        splitright = true,
        splitbelow = true,
        title = true,
        clipboard = 'unnamedplus',
        fixeol = false,
        completeopt = 'menu,menuone,noselect',
        backup = false,
        showcmd = true,
        cmdheight = 1,
        expandtab = true,
        laststatus = 2,
        mouse = 'a',
        mousescroll = 'ver:3,hor:0', -- Disable horizontal mouse scroll
        breakindent = true,
        wrap = true,
        -- Search
        ignorecase = true,
        smartcase = true,
        showmatch = true,
        hlsearch = true,
        incsearch = true,
        -- Tabs
        shiftwidth = 4,
        tabstop = 4,
        smartindent = true,
        termguicolors = false,

        guicursor = '',
        inccommand = 'split',
        virtualedit = 'block',
    },
    ---Window scoped variables
    window = {
        conceallevel = 2,
        number = true,
        relativenumber = true,
    },
    global = {
        mapleader = ' ',
        loaded_netrw = 1,
        loaded_netrwPlugin = 1,
    },
}

---@type Options
local options

---
---@param opts table
function M.setup(opts)
    options = vim.tbl_deep_extend('force', defaults, opts or {}) or {}
    set_options(opt, options.options)
    set_options(wo, options.window)
    set_options(global_scope, options.global)
    vim.scriptencoding = 'utf-8'
    opt.path:append({ '**' })
    setup_mappings()
    require('config.autocmd')
    vim.cmd([[set nofoldenable]])
    -- Не автокомментировать новые линии при переходе на новую строку
    vim.cmd([[autocmd BufEnter * set fo-=c fo-=r fo-=o]])

    -- highlight yanked text for 200ms using the "Visual" highlight group
    vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
    augroup end
    ]])
    -- list chars characters: eol:⏎;
    vim.cmd(
        [[set listchars=eol:¬,space:·,tab:>-,trail:·,extends:>,precedes:<]]
    )
    vim.opt.fillchars = {
        fold = ' ',
        vert = '┃',
        horiz = '━',
        horizup = '┻',
        horizdown = '┳',
        vertleft = '┫',
        vertright = '┣',
        verthoriz = '╋',
    }
    vim.cmd([[set list]])

    local map = vim.keymap.set

    function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        map('t', '<esc>', [[<C-\><C-n>]], opts)
        map('t', 'jk', [[<C-\><C-n>]], opts)
        map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    map({ 'n', 'v' }, '<leader>mp', function()
        require('conform').format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = 'Format file or range (in visual mode)' })

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    vim.opt.statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} ' -- Align relative number
end

_G.config = M

local config = _G.config
config.setup({})
