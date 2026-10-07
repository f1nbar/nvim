local MiniGit = require("mini.git")
MiniGit.setup()

vim.api.nvim_set_hl(0, "GitBlameHashRoot", { link = "Tag" })
vim.api.nvim_set_hl(0, "GitBlameHash", { link = "Identifier" })
vim.api.nvim_set_hl(0, "GitBlameAuthor", { link = "String" })
vim.api.nvim_set_hl(0, "GitBlameDate", { link = "Comment" })

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitCommandSplit",
    callback = function(e)
        if e.data.git_subcommand ~= "blame" then
            return
        end
        local win_src = e.data.win_source
        local buf = e.buf
        local win = e.data.win_stdout
        -- Opts
        vim.bo[buf].modifiable = false
        vim.wo[win].wrap = false
        vim.wo[win].cursorline = true
        -- View
        vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
        vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })
        vim.wo[win].scrollbind, vim.wo[win_src].scrollbind = true, true
        vim.wo[win].cursorbind, vim.wo[win_src].cursorbind = true, true
        -- Vert width
        if e.data.cmd_input.mods:match("vertical") then
            local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
            local width = vim.iter(lines):fold(-1, function(acc, ln)
                local stat = string.match(ln, "^%S+ %b()")
                return math.max(acc, vim.fn.strwidth(stat))
            end)
            width = width + vim.fn.getwininfo(win)[1].textoff
            vim.api.nvim_win_set_width(win, width)
        end
        -- Highlight
        vim.fn.matchadd("GitBlameHashRoot", [[^^\w\+]])
        vim.fn.matchadd("GitBlameHash", [[^\w\+]])
        local leftmost = [[^.\{-}\zs]]
        vim.fn.matchadd("GitBlameAuthor", leftmost .. [[(\zs.\{-} \ze\d\{4}-]])
        vim.fn.matchadd("GitBlameDate", leftmost .. [[[0-9-]\{10} [0-9:]\{8} [+-]\d\+]])
    end,
})

-- Helper + keymaps for opening blame on current file / line
local function git_blame_current_file(mods, extra_args)
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end

    -- Find git top-level for the file's directory
    local dir = vim.fn.fnamemodify(file, ":h")
    local toplevel = nil
    local rev = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel")
    if vim.v.shell_error == 0 and rev[1] and rev[1] ~= "" then
        toplevel = rev[1]
    end

    -- Compute path relative to repo root if possible, otherwise use absolute path
    local rel = file
    if toplevel and file:sub(1, #toplevel) == toplevel then
        rel = file:sub(#toplevel + 2)
        if rel == "" then rel = vim.fn.fnamemodify(file, ":t") end
    end

    local args = { "blame" }
    if extra_args then
        for _, a in ipairs(extra_args) do table.insert(args, a) end
    end
    table.insert(args, "--")
    table.insert(args, rel)

    vim.cmd({ cmd = "Git", args = args, mods = mods or {} })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.keymap.set("n", "<leader>gb", function()
    git_blame_current_file({ vertical = true })
end, { desc = "mini.git: blame current file (vertical)" })

vim.keymap.set("n", "<leader>gL", function()
    local l = vim.fn.line(".")
    git_blame_current_file({}, { ("-L%d,%d"):format(l, l) })
end, { desc = "mini.git: blame current line" })
