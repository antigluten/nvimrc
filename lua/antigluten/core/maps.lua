vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) Netwr only, currently disabled

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', {noremap = true})
vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', {noremap = true})

vim.api.nvim_set_keymap("i", "jk", "<Esc>", {noremap=false})
