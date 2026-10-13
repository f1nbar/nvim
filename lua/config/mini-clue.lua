local miniclue = require("mini.clue")

miniclue.setup({
    triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
    },

    clues = {
        { mode = "n", keys = "<Leader>b", desc = "Find buffers" },
        { mode = "n", keys = "<Leader>c", desc = "Close buffer / code" },
        { mode = "n", keys = "<Leader>cf", desc = "Format buffer" },
        { mode = "n", keys = "<Leader>e", desc = "Toggle file tree" },
        { mode = "n", keys = "<Leader>f", desc = "Find files" },
        { mode = "n", keys = "<Leader>F", desc = "Live grep" },
        { mode = "n", keys = "<Leader>h", desc = "Clear search highlight" },
        { mode = "n", keys = "<Leader>j", desc = "+Java" },
        { mode = "n", keys = "<Leader>q", desc = "Quit Neovim" },
        { mode = "n", keys = "<Leader>t", desc = "+test/terminal" },
        { mode = "n", keys = "<Leader>w", desc = "Save buffer" },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },

    window = {
        delay = 900,
        config = {
            anchor = "SE",
            border = "rounded",
            col = -1,
            row = 1,
            width = "auto",
        },
    },
})
