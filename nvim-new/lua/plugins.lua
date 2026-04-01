vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/goolord/alpha-nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range("3"),
    },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://codeberg.org/andyg/leap.nvim" },
    { src = "https://github.com/folke/sidekick.nvim" },
    { src = "https://github.com/neanias/everforest-nvim" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    -- { src = "https://github.com/ThePrimeagen/harpoon",   name = "harpoon2" }, TODO wait to fix

})

require("config.mini-completion")
require("config.mini-pick")
require("mini.icons").setup()
require("config.mini-sessions")
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.misc").setup()
MiniMisc.setup_auto_root()
require("mini.git").setup()
require("mini.diff").setup()
require("mini.statusline").setup()
require("copilot").setup()


require("config.lsp")
require("config.toggleterm")
-- require("config.harpoon")
require("config.alpha")
require("config.sidekick")
