local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	-- themes
	"dasupradyumna/midnight.nvim",
	'Yazeed1s/minimal.nvim',
	"bluz71/vim-moonfly-colors",
	"EdenEast/nightfox.nvim",
	"aktersnurra/no-clown-fiesta.nvim",
	{
		'daltonmenezes/aura-theme',
		name = 'aura-theme',
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. '/packages/neovim')
		end,
	},
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
	"metalelf0/base16-black-metal-scheme",

	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { "vimdoc", "javascript", "typescript", "css", "html", "tsx", "rust", "lua", "kotlin" },
				sync_install = false,
				auto_install = true,
				indent = { enable = true },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99
			vim.opt.foldenable = false
			vim.opt.conceallevel = 0
		end,
	},

	{
		'numToStr/Comment.nvim',
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
	},

	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	{
		-- Auto-installs Mason packages that aren't lspconfig servers, so a fresh
		-- machine bootstraps the JetBrains kotlin-lsp that kotlin.nvim drives.
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		dependencies = { 'williamboman/mason.nvim' },
		config = function()
			require('mason-tool-installer').setup({ ensure_installed = { 'kotlin-lsp' } })
		end,
	},
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',

	'udalov/kotlin-vim',

	{
		'AlexandrosAlexiou/kotlin.nvim',
		ft = { 'kotlin' },
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
		config = function()
			require('kotlin').setup({
				-- Root-only markers (no build.gradle.kts): these exist only at the
				-- Gradle/Maven root, so root detection lands there instead of the
				-- nearest subproject, and the whole multi-module build imports with
				-- its full plugin classpath.
				root_markers = {
					'settings.gradle.kts',
					'settings.gradle',
					'gradlew',
					'mvnw',
				},
			})
		end,
	},

	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	'lewis6991/gitsigns.nvim',

	{
		'akinsho/git-conflict.nvim',
		version = "*",
		config = function()
			require('git-conflict').setup()
		end,
	},

	'nvim-tree/nvim-web-devicons',

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	'stevearc/dressing.nvim',

	'github/copilot.vim',
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		dependencies = {
			'github/copilot.vim',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('CopilotChat').setup({
				model = 'gpt-4.1',
			})
		end,
	},
})
