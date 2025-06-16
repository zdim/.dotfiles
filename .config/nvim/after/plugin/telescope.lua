local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.buffers, {})

-- two separate find_files bindings - one includes node_modules & .git ignored
vim.keymap.set('n', '<leader>PF', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set('n', '<leader>pf', function()
	builtin.find_files({ hidden = true })
end)

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>pg', builtin.git_status, {});
vim.keymap.set('n', '<leader>hc', builtin.commands, {});
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {});
vim.keymap.set('n', '<leader>PS', builtin.live_grep, {})

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            'node_modules', '.git/'
        },
    }
});

