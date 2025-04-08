-- Ensure packer is installed
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

local packer_bootstrap = ensure_packer()

-- Use packer to manage plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'           -- Packer itself
  use 'neovim/nvim-lspconfig'            -- LSP config (untouched)
  use 'hrsh7th/nvim-cmp'                 -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'             -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                 -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'         -- LuaSnip source for cmp
  use 'hrsh7th/cmp-buffer'               -- Buffer source for nvim-cmp
  use 'ThePrimeagen/harpoon'             -- Harpoon plugin for quick file navigation
  use 'nvim-telescope/telescope.nvim'    -- Telescope for fuzzy file search
  use 'lewis6991/gitsigns.nvim'          -- Git integration
  use 'folke/which-key.nvim'             -- Which-key plugin for key bindings
  use 'nvim-treesitter/nvim-treesitter'  -- Treesitter for syntax highlighting

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Load plugin-specific settings and mappings

-- Telescope settings
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<Leader>gs', function()
  telescope.grep_string({ search = vim.fn.input("Grep> ") })
end)

-- Keybindings for Harpoon (still includes the Harpoon plugin configuration)
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  highlight = { enable = true },
}

-- GitSigns settings
require('gitsigns').setup()

-- Which-key settings
require("which-key").setup {}

-- Colorscheme settings
vim.cmd.colorscheme('rose-pine')
vim.api.nvim_set_hl(0,"Normal", { bg="none" })
vim.api.nvim_set_hl(0,"NormalFloat", { bg="none" })

-- UndoTree settings
vim.keymap.set('n', '<Leader>u', vim.cmd.UndotreeToggle)

-- Completion setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
})

