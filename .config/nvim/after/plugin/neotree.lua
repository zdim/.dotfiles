local tree = require('neo-tree')

tree.setup({
	hide_dotfiles = false,
	hide_gitignored = false,
})

vim.keymap.set('n', '<leader>b', ':Neotree toggle focus right<cr>')
vim.keymap.set('n', '<leader>s', ':Neotree float git_status<cr>')
vim.keymap.set('n', '|', ':Neotree reveal toggle<cr>')
vim.keymap.set('n', '\\', ':Neotree toggle current reveal_force_cwd<cr>') 
