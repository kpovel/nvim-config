-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    requires = { { "nvim-lua/plenary.nvim" } }
  }

  use({
    "folke/tokyonight.nvim",
    as = "tokyonight",
  })

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end, }

  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")

  use("mbbill/undotree")
  use("lewis6991/gitsigns.nvim")

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { "j-hui/fidget.nvim" },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      -- { 'L3MON4D3/LuaSnip' },
    }
  }

  use("eandrju/cellular-automaton.nvim")
  use("laytan/cloak.nvim")
end)
