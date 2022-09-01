-- :help options
local options = {
	fileencoding = "utf-8",				-- set a default encoding type
	showmatch  = true,				-- show matching brackets
	number = true,					-- line number use with relative number for hybrid 
	relativenumber = true, 				-- relative numbers
	clipboard = "unnamedplus", 			-- use sys clipboard 
	termguicolors = true, 				-- term colours
	cmdheight = 2, 					-- may change back, more space for cmd
	completeopt = { "menuone", "noselect" }, 	-- cmp options
	conceallevel = 0, 			-- so that `` is visible in markdown files
	hlsearch = true, 				-- highlight all matches on previous search pattern
	ignorecase = true, 				-- ignore case in search patterns
	mouse = "a", 					-- allow the mouse to be used in neovim
	pumheight = 10, 				-- pop up menu height
	showmode = false, 				-- don't show INSERT, NORMAL etc 
	showtabline = 2, 				-- always show tabs
	smartcase = true, 				-- smart case
	smartindent = true, 				-- improve indenting for supported languages 
	splitbelow = true, 				-- force all horizontal splits to go below current window
	splitright = true, 				-- force all vertical splits to go to the right of current window
	swapfile = false, 				-- no swapfile
	timeoutlen = 500, 				-- time to wait for a mapped sequence to complete (in milliseconds), whichkey
	updatetime = 300, 				-- faster completion (4000ms default)
	writebackup = false, 				-- if a file is being edited by another program it is not allowed to be edited
	expandtab = true, 				-- convert tabs to spaces
	shiftwidth = 2, 				-- the number of spaces inserted for each indentation
	tabstop = 4, 					-- insert 4 spaces for a tab, 8 is weird lol
	cursorline = false, 				-- highlight the current line
	numberwidth = 4, 				-- set number column width to 2 {default 4}
	signcolumn = "yes", 				-- always show the sign column
	wrap = false,  					-- display lines as one long line
	scrolloff = 8, 					-- centers cursor
	sidescrolloff = 8, 				-- centers cursor
}

vim.cmd "set whichwrap+=<,>,[,],h,l" 		-- treat words with commas etc as single words
vim.cmd "cmap w!! w !sudo tee %" 		-- you can't stop me!!

for k, v in pairs(options) do
	vim.opt[k] = v
end


