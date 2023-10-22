local tree = require('neo-tree')

vim.keymap.set('n', '<leader>b', ':Neotree toggle show right<cr>') 
vim.keymap.set('n', '<leader>s', ':Neotree float git_status<cr>')
vim.keymap.set('n', '|', ':Neotree reveal<cr>')
vim.keymap.set('n', '\\', ':Neotree toggle current reveal_force_cwd<cr>') 
