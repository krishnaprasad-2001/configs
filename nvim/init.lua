-- Packer installation check (only runs if missing)
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Plugin specification
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  
  -- LSP core
  use 'neovim/nvim-lspconfig'
  
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }
  
  -- Harpoon
  use 'ThePrimeagen/harpoon'
  
  -- Utilities
  use 'nvim-lua/plenary.nvim'
end)

-- LSP Setup (using your working config)
require('lspconfig').bashls.setup{}

-- Autocompletion setup
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- Harpoon setup
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
for i = 1, 4 do
  vim.keymap.set('n', '<C-'..i..'>', function() ui.nav_file(i) end)
end

-- Basic settings
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
