vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
	end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'ts_ls', 'eslint', 'rust_analyzer' },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({
				capabilities = lsp_capabilities,
			})
		end,
		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							}
						}
					}
				}
			})
		end,
	}
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})


-- local lsp = require('lsp-zero')
-- local cmp = require('cmp')
--
-- lsp.preset("recommended")
--
-- lsp.ensure_installed({
-- 	'ts_ls',
-- 	-- NOTE: eslint 4.10.0 has an issue, prefer 4.8.0
-- 	'eslint',
-- 	'rust_analyzer',
-- 	'gopls',
-- 	'terraformls',
-- 	'tflint',
-- 	'tailwindcss'
-- })
--
-- require('lspconfig').ts_ls.setup({})
--
-- lsp.set_server_config({
-- 	on_init = function(client)
-- 		client.server_capabilities.semanticTokensProvider = nil
-- 	end,
-- })
--
-- lsp.on_attach(function(client, bufnr)
-- 	local opts = {buffer = bufnr, remap = false}
--
-- 	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
-- 	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
-- 	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
-- 	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
-- 	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
-- 	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
-- 	vim.keymap.set("n", "<leader>v.", function() vim.lsp.buf.code_action() end, opts)
-- 	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
-- 	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
-- 	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--
-- end)
--
-- lsp.format_on_save({
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ['eslint'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
--         ['rust_analyzer'] = { 'rust' },
-- 		['terraformls'] = { 'terraform', 'tf' },
--     }
-- })
--
-- lsp.setup()
--
-- cmp.setup({
--     mapping = cmp.mapping.preset.insert({
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         ['<Tab>'] = lsp.cmp_action().luasnip_supertab(),
--         ['<S-Tab>'] = lsp.cmp_action().luasnip_shift_supertab(),
--         ['<C-Space>'] = cmp.mapping.complete(),
--     })
-- })
