local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset("recommended")

lsp.ensure_installed({
	'ts_ls',
	-- NOTE: eslint 4.10.0 has an issue, prefer 4.8.0
	'eslint',
	'rust_analyzer',
	'gopls',
	'terraformls',
	'tflint'
})

require('lspconfig').ts_ls.setup({})

lsp.set_server_config({
	on_init = function(client)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>v.", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

end)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['eslint'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        ['rust_analyzer'] = { 'rust' },
		['terraformls'] = { 'terraform', 'tf' },
    }
})

lsp.setup()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = lsp.cmp_action().luasnip_supertab(),
        ['<S-Tab>'] = lsp.cmp_action().luasnip_shift_supertab(),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})
