vim.o.termguicolors = true

-- Rose Pine (Moon variant, the standard dark one)
vim.g.rose_pine = {
  style = "main",            -- "main" | "medium" | "moon" | "nihio"
  variant = "main",          -- "main" | "dawn" | "moon"
  background = "dark",       -- "dark" | "light"
  highlight_darkness = 0.15, -- 0.0 - 1.0
  bold = true,
  italic = true,
  underline = true,
}
vim.cmd.colorscheme("rose-pine")
