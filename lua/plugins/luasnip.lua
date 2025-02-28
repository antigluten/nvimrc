return {
    'L3MON4D3/LuaSnip',
    lazy = false,
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    config = function()
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load({
            paths = vim.fn.stdpath('config') .. '/snippets/',
        })

        local ls = require('luasnip')
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local extras = require('luasnip.extras')
        local rep = extras.rep
        local fmt = require('luasnip.extras.fmt').fmt
        local c = ls.choice_node
        local f = ls.function_node
        local d = ls.dynamic_node
        local sn = ls.snippet_node

        ls.add_snippets('norg', {
            s({ trig = 'link', name = 'Add this -> []{}' }, {
                t('['),
                i(1),
                t(']'),
                t('{'),
                i(2),
                t('}'),
            }),
        })
    end,
}
