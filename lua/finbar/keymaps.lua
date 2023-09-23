-- Execute commands silently
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
keymap("i", "jk", "<ESC>", opts)

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
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "gd", "<cmd>telescope lsp_definitions<cr>", opts)
keymap("n", "gd", "<cmd>telescope lsp_declarations<cr>", opts)
keymap("n", "gi", "<cmd>telescope lsp_implementations<cr>", opts)
keymap("n", "gr", "<cmd>telescope lsp_references<cr>", opts)
keymap("n", "<m-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

keymap("n", "<leader>d;", "<cmd>lua require 'harpoon.ui'.nav_file(4)<cr>", opts)

-- DAP
--[[ keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts ]]
--[[ keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts) ]]
--[[ keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts) ]]
--[[ keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts) ]]
--[[ keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts) ]]
--[[ keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts) ]]
--[[ keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts) ]]
--[[ keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts) ]]
