vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', {
    noremap = true
})

-- vim.keymap.set('i', '<Esc>')

vim.api.nvim_set_keymap("i", "jk", "<Esc>", {noremap=false})
