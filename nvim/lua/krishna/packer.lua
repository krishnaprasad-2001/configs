-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Simple plugins can be specified as strings
	use 'rstacruz/vim-closer'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config=function()
			vim.cmd('colorscheme rose-pine')
		end
	})
	use('nvim-treesitter/nvim-treesitter', {run= ':TSUpdate'})
	use('nvim-treesitter/playground')
	use('ThePrimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use('neovim/nvim-lspconfig')
	use 'hrsh7th/nvim-cmp'                -- Completion engine
	use 'hrsh7th/cmp-nvim-lsp'            -- LSP source for nvim-cmp
	use 'L3MON4D3/LuaSnip'                -- Snippet engine
	use 'saadparwaiz1/cmp_luasnip'        -- LuaSnip source for cmp

end)
