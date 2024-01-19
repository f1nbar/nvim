-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup ({
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- useful lua functions used ny lots of plugins
  -- Git
  "lewis6991/gitsigns.nvim", -- show git differences
  { "kdheepak/lazygit.nvim", dependencies = "nvim-lua/plenary.nvim" }, 
  "tpope/vim-fugitive", -- Git commands
  -- Terminal
  "akinsho/toggleterm.nvim", -- terminals everywhere
  -- Theme
  "catppuccin/nvim",
  "stevearc/oil.nvim", -- files
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "goolord/alpha-nvim", --greeter
  -- cmp plugins
   "hrsh7th/nvim-cmp", -- The completion plugin
   "hrsh7th/cmp-buffer", -- buffer completions
   "hrsh7th/cmp-path", -- path completions
   "hrsh7th/cmp-cmdline", -- cmdline completions
   "saadparwaiz1/cmp_luasnip", -- snippet completions
   "hrsh7th/cmp-nvim-lsp", -- lsp completions
   "hrsh7th/cmp-nvim-lua", -- completions for neovim lua API
   { "scalameta/nvim-metals", dependencies = "nvim-lua/plenary.nvim" }, -- Scala LSP
 -- Snippets
   { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" }, --snippet engine
  -- LSP
   "williamboman/nvim-lsp-installer", -- simple to use language server installer
   "neovim/nvim-lspconfig", -- enable LSP
   --[[ "hinell/lsp-timeout.nvim", -- save ram ]]
   "luckasRanarison/clear-action.nvim", -- TODO do I want this?
  -- Telescope for finding files and live grep
   "nvim-telescope/telescope.nvim",
   "debugloop/telescope-undo.nvim",
   "nvim-telescope/telescope-dap.nvim",
   "nvim-telescope/telescope-media-files.nvim",
   { "nvim-telescope/telescope-fzf-native.nvim", build="make" },
   "ahmedkhalf/project.nvim", -- find recently opened projects

  -- Syntax highlighting with comments
  {
    "nvim-treesitter/nvim-treesitter",
    build=":TSUpdate"
  },
   "nvim-treesitter/nvim-treesitter-textobjects",
   "nvim-treesitter/refactor",
   "JoosepAlviste/nvim-ts-context-commentstring", -- Smarter comments with treesitter intergration
   "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
   "numToStr/Comment.nvim", -- Easily comment stuff with "gcc etc",
   "nvimtools/none-ls.nvim",
   "RRethy/vim-illuminate",
   "ThePrimeagen/harpoon",
   "chentoast/marks.nvim", -- Better marks
  -- which-key
   "folke/which-key.nvim",
-- DAP for debugging
   "mfussenegger/nvim-dap",
   "rcarriga/nvim-dap-ui",
   "ravenxrz/DAPInstall.nvim",
  -- Java
   "mfussenegger/nvim-jdtls",
    {
        'stevearc/overseer.nvim',
        opts = {},
    },
    "zbirenbaum/copilot.lua",
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup()
        end
    }


 })
