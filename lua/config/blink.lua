local cmp = require("blink.cmp")
local fuzzy = require("blink.cmp.fuzzy")
fuzzy.set_implementation('lua')
cmp.setup({
    completion = {
        menu = {
            draw = {
                treesitter = { "lsp" },
            },
        },
    },
    keymap = {
        preset = "super-tab",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "hide" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "accept" },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})
