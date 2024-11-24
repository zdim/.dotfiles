local tree = require('neo-tree')

tree.setup({
	hide_dotfiles = false,
	hide_gitignored = false,
	close_if_last_window = true,
	filesystem = {
		filtered_items = {
			-- shows hidden files by default
			visible = true,
		}
	},
	event_handlers = {
		{
			event = "neo_tree_popup_input_ready",
			handler = function()
				-- enter input popup with normal mode by default.
				vim.cmd("stopinsert")
			end,
		},
		{
			event = "neo_tree_popup_input_ready",
			---@param args { bufnr: integer, winid: integer }
			handler = function(args)
				-- map <esc> to enter normal mode (by default closes prompt)
				-- don't forget `opts.buffer` to specify the buffer of the popup.
				vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
			end,
		}
	}
})

vim.keymap.set('n', '<leader>b', ':Neotree toggle focus right<cr>')
vim.keymap.set('n', '<leader>s', ':Neotree float git_status<cr>')
vim.keymap.set('n', '|', ':Neotree reveal toggle<cr>')
vim.keymap.set('n', '\\', ':Neotree toggle current reveal_force_cwd<cr>')
