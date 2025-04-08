require("krishna")
-- LSP setup for bash using bash-language-server
-- Packer bootstrap (make sure packer is installed)
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

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'           -- Packer
  use 'neovim/nvim-lspconfig'            -- LSP config
  use 'hrsh7th/nvim-cmp'                 -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'             -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                 -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'         -- LuaSnip source for cmp
  use 'nvim-lua/plenary.nvim'
  use 'hrsh7th/cmp-buffer'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- nvim-cmp setup
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
     { name = "buffer" }, -- 👈 enables buffer-based suggestions
  },
})

-- LSP setup for Bash
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.bashls.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    print("✅ Bash LSP attached")
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" }) -- <leader>a to add file to harpoon
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon quick menu" }) -- <C-e> to open harpoon menu

-- Keybindings for navigating between the first 4 files in harpoon
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Navigate to file 1" })
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Navigate to file 2" })
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Navigate to file 3" })
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Navigate to file 4" })

