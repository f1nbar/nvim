require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
    },
    appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
    },
    completion = {
        documentation = { auto_show = true},
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot"},
        providers = {
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                score_offset = 100,
                async = true,
            },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
