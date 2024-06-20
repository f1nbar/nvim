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
  "lewis6991/gitsigns.nvim", -- git tools 
  "sindrets/diffview.nvim", -- git diff TODO do I want this?
  { "kdheepak/lazygit.nvim", dependencies = "nvim-lua/plenary.nvim" }, 
  "tpope/vim-fugitive", -- Git commands
  "akinsho/toggleterm.nvim", -- terminals everywhere
  -- Theme
  "catppuccin/nvim",
  "kyazdani42/nvim-web-devicons",
{"nvim-neo-tree/neo-tree.nvim", dependencies = "MunifTanjim/nui.nvim"},
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
   "williamboman/mason.nvim", -- simple to use language server installer
   "williamboman/mason-lspconfig.nvim",
   "neovim/nvim-lspconfig", -- enable LSP
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" }, -- markdown preview
  -- Telescope for finding files and live grep
   "nvim-telescope/telescope.nvim",
   "debugloop/telescope-undo.nvim",
   "folke/trouble.nvim",
   "nvim-telescope/telescope-dap.nvim",
   "nvim-telescope/telescope-media-files.nvim",
   "nvim-telescope/telescope-ui-select.nvim",
   { "nvim-telescope/telescope-fzf-native.nvim", build="make" },
   "ahmedkhalf/project.nvim", -- find recently opened projects
  {
    "nvim-treesitter/nvim-treesitter",
    build=":TSUpdate"
  },
   "nvim-treesitter/nvim-treesitter-textobjects",
   "nvim-treesitter/refactor",
   "JoosepAlviste/nvim-ts-context-commentstring", -- Smarter comments with treesitter intergration
   "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
   "nvimtools/none-ls.nvim",
   "RRethy/vim-illuminate",
   "ThePrimeagen/harpoon",
   "chentoast/marks.nvim", -- Better marks
  -- which-key
   "folke/which-key.nvim",
-- DAP for debugging
   "mfussenegger/nvim-dap",
   "rcarriga/nvim-dap-ui",
   "nvim-neotest/nvim-nio", -- async dep
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
    },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
  },
  -- { "mistricky/codesnap.nvim", build = "make" },
   "alexghergh/nvim-tmux-navigation"
 })
