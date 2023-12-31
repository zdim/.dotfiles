local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>pg', builtin.git_status, {});
vim.keymap.set('n', '<leader>hc', builtin.commands, {});
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {});

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            'node_modules', '.git'
        },
    }
});

