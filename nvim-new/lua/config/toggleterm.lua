local toggleterm = require("toggleterm")

toggleterm.setup({
    size = 20,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = -30,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- Terminal keymaps (buffer local, modern API)
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        local opts = { buffer = true }

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end,
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "curved",
    },
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gl", function()
    lazygit:toggle()
end, { desc = "LazyGit" })
