-- :help options
local options = {
    showmatch      = true,  -- show matching brackets
    number         = true,  -- line number use with relative number for hybrid
    relativenumber = true,  -- relative numbers
    clipboard      = "unnamedplus", -- use sys clipboard
    cmdheight      = 2,     -- may change back, more space for cmd
    ignorecase     = true,  -- ignore case in search patterns
    pumheight      = 10,    -- pop up menu height
    showmode       = false, -- don't show INSERT, NORMAL etc
    showtabline    = 0,     -- don't show tabs now that we are using harpoon
    smartcase      = true,  -- smart case
    splitbelow     = true,  -- force all horizontal splits to go below current window
    splitright     = true,  -- force all vertical splits to go to the right of current window
    swapfile       = false, -- no swapfile
    timeoutlen     = 500,   -- time to wait for a mapped sequence to complete (in milliseconds), whichkey
    updatetime     = 300,   -- faster completion (4000ms default)
    writebackup    = false, -- if a file is being edited by another program it is not allowed to be edited
    expandtab      = true,  -- convert tabs to spaces
    shiftwidth     = 4,     -- the number of spaces inserted for each indentation
    tabstop        = 4,     -- insert 4 spaces for a tab, 8 is weird lol
    signcolumn     = "yes", -- always show the sign column
    wrap           = false, -- display lines as one long line
    scrolloff      = 8,     -- centers cursor
    sidescrolloff  = 8,     -- centers cursor
    undofile       = true,  -- undofiles across sessions
    undodir        = vim.fn.stdpath("data") .. "/undo"

}

vim.cmd "cmap w!! w !sudo tee %"                             -- you can't stop me!!
vim.cmd "command! BufOnly execute '%bdelete|edit#|bdelete#'" -- Delete all buffers but current

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.api.nvim_create_user_command('PackUpdate', function()
    vim.pack.update()
end, {})
