-- Reload files changed by pi or another external process when nvim regains
-- focus or has been idle. `checktime` respects modified buffers and will not
-- overwrite unsaved local edits.
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" then
            vim.cmd("checktime")
        end
    end,
})

local function session_name()
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(cwd, ":h:t") .. "-" .. vim.fn.fnamemodify(cwd, ":t")
end

local function no_explicit_file()
    local argc = vim.fn.argc()
    if argc == 0 then
        return true
    end
    if argc == 1 then
        return vim.fn.isdirectory(vim.fn.argv(0)) == 1
    end
    return false
end

vim.api.nvim_create_autocmd("VimEnter", {
    nested = true,
    callback = function()
        if not no_explicit_file() then
            return
        end
        local sessions = require("mini.sessions")
        local name = session_name()
        if sessions.detected[name] then
            sessions.read(name)
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local name = session_name()
        require("mini.sessions").write(name, { force = true })
    end,
})
