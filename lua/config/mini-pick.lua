require("mini.pick").setup({
    options = {
        content_from_bottom = true,
        use_cache = false,
    },

    window = {
        config = function()
            local height = math.floor(vim.o.lines * 0.7)
            local width  = math.floor(vim.o.columns * 0.7)
            return {
                anchor = "NW",
                height = height,
                width = width,
                row = math.floor((vim.o.lines - height) / 2),
                col = math.floor((vim.o.columns - width) / 2),
                border = "rounded",
            }
        end,
    },

    mappings = {
        move_down         = "<C-j>",
        move_up           = "<C-k>",
        scroll_down       = "<C-d>",
        scroll_up         = "<C-u>",
        choose_in_split   = "<C-x>",
        choose_in_vsplit  = "<C-v>",
        choose_in_tabpage = "<C-t>",
    },
})
