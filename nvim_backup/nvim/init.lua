-- Auto-install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Load and configure plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")          -- Packer manages itself
	use("neovim/nvim-lspconfig")           -- LSP configs
	use("hrsh7th/nvim-cmp")                -- Autocompletion
	use("hrsh7th/cmp-nvim-lsp")            -- LSP source for cmp
	use("L3MON4D3/LuaSnip")                -- Snippet engine
	use("saadparwaiz1/cmp_luasnip")        -- Snippets for cmp
	use("hrsh7th/cmp-buffer")              -- Buffer completion
	use("rose-pine/neovim")                -- Theme
	use("nvim-lua/plenary.nvim")           -- Lua functions many plugins use
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	if packer_bootstrap then
		require("packer").sync()
	end
end)

