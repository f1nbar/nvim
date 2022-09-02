local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- Git
  use "lewis6991/gitsigns.nvim" -- show git differences

  -- Terminal
  use {"akinsho/toggleterm.nvim", tag = "v2.*"} -- useful terminal

  -- Theme
  use "catppuccin/nvim"
  use "romgrk/barbar.nvim" -- tabs and buffers
  use "nvim-lualine/lualine.nvim" -- statusline
  use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" } -- greeter


  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completions
  use "hrsh7th/cmp-nvim-lua" -- completions for neovim lua API

 -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- Telescope for finding files and live grep
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "ahmedkhalf/project.nvim" -- find recently opened projects

  -- Syntax highlighting with comments
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring" -- Smarter comments with treesitter intergration
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff with "gcc etc"
  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"

  -- NvimTree file tree
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- Markdown Preview //:Glow to Preview
  use "ellisonleao/glow.nvim"

  -- which-key
  use "folke/which-key.nvim"

-- DAP for debugging
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "ravenxrz/DAPInstall.nvim"

  -- Java
  use "mfussenegger/nvim-jdtls"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
