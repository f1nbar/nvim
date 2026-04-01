local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

-- Movement is now centered
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Normal --
-- Better window navigation ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows and control
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers with shift L and H
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- jk to escape insert mode
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down with alt and jk in visual mode
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.keymap.set("t", "<C-h>", "<C-h>", { buffer = true })
        vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = true })
        vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = true })
        vim.keymap.set("t", "<C-l>", "<C-l>", { buffer = true })
    end,
})

keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<m-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

-- Leader shortcuts (translated from which-key)

keymap("n", "<leader>w", ":w!<CR>", opts)             -- Save
keymap("n", "<leader>q", ":q!<CR>", opts)             -- Quit
keymap("n", "<leader>c", ":bdelete!<CR>", opts)       -- Close Buffer
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)     -- No Highlight

keymap("n", "<leader>e", ":Neotree toggle<CR>", opts) -- File tree

vim.keymap.set("n", "<leader>f", function()
    require("mini.pick").builtin.files()
end)

vim.keymap.set("n", "<leader>F", function()
    require("mini.pick").builtin.grep_live()
end)

-- local harpoon = require("harpoon")
--
-- vim.keymap.set("n", "<leader>df", function()
--     harpoon.ui:toggle_quick_menu(harpoon:list())
-- end, { desc = "Harpoon Menu" })
--
-- vim.keymap.set("n", "<leader>da", function()
--     harpoon:list():add()
-- end, { desc = "Harpoon Add File" })
--
-- vim.keymap.set("n", "<leader>dj", function()
--     harpoon:list():select(1)
-- end, { desc = "Harpoon File 1" })
--
-- vim.keymap.set("n", "<leader>dk", function()
--     harpoon:list():select(2)
-- end, { desc = "Harpoon File 2" })
--
-- vim.keymap.set("n", "<leader>dl", function()
--     harpoon:list():select(3)
-- end, { desc = "Harpoon File 3" })
--
-- vim.keymap.set("n", "<leader>d;", function()
--     harpoon:list():select(4)
-- end, { desc = "Harpoon File 4" })
