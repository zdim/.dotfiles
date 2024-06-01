local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

vim.cmd [[packadd packer.nvim]]

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', 
        tag = '0.1.2',
		requires = ({ 'nvim-lua/plenary.nvim' })
	}

	-- start themes
	use ({
		'dasupradyumna/midnight.nvim',
		as = 'midnight',
		config = function()
			vim.cmd('colorscheme midnight')
		end
	})

	use ({
		'bluz71/vim-moonfly-colors',
		as = 'moonfly'
	})

	use {
		'daltonmenezes/aura-theme',
		rtp = 'packages/neovim',
		config = function()
			vim.cmd("colorscheme aura-dark") -- Or any Aura theme available
		end
	}

	use "EdenEast/nightfox.nvim"
	use "aktersnurra/no-clown-fiesta.nvim"
	-- end themes

	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	use {
		'numToStr/Comment.nvim',
		requires = {
			'JoosepAlviste/nvim-ts-context-commentstring'
		}
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

	use 'udalov/kotlin-vim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'lewis6991/gitsigns.nvim'

	use {'akinsho/git-conflict.nvim', tag = "*", config = function()
		require('git-conflict').setup()
	end}
	
	use 'nvim-tree/nvim-web-devicons'

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}

	use 'stevearc/dressing.nvim'
	
	-- bootstrap packer itself
	-- must go at the end
	if packer_bootstrap then
		require('packer').sync()
	end
end)
