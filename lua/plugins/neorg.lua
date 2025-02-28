local M = {
    'nvim-neorg/neorg',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-neorg/lua-utils.nvim',
        'pysan3/pathlib.nvim',
    },
}

local modules = {
    ['core.defaults'] = {},
    ['core.completion'] = {
        config = {
            engine = 'nvim-cmp',
        },
    },
    ['core.concealer'] = {
        config = {
            icon_preset = 'diamond',
        },
    },
    ['core.dirman'] = {
        config = {
            workspaces = {
                notes = '~/notes',
            },
            index = 'workspace.norg',
            use_popup = false,
            inject_metadata = true,
        },
    },
    ['core.keybinds'] = {
        config = {
            hook = function(keybinds)
                keybinds.remap_event(
                    'norg',
                    'n',
                    '<C-n>',
                    'core.dirman.new.note'
                )
            end,
        },
    },
    ['core.presenter'] = {
        config = {
            zen_mode = 'zen-mode',
        },
    },
    ['core.esupports.metagen'] = {
        config = {
            type = 'auto',
            update_date = true,
            author = 'Vladimir Gusev',
        },
    },
    ['core.qol.toc'] = {},
    ['core.qol.todo_items'] = {},
    ['core.looking-glass'] = {},
    ['core.export'] = {},
    ['core.export.markdown'] = { config = { extensions = 'all' } },
    ['core.summary'] = {},
    ['core.tangle'] = { config = { report_on_empty = false } },
    ['core.ui.calendar'] = {},
    ['core.journal'] = {},
}

M.opts = {
    load = modules,
}

M.dependencies = {
    { 'nvim-lua/plenary.nvim' },
}

return {
    M,
}
