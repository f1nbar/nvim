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
        local name = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
        if sessions.detected[name] then
            sessions.read(name)
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local name = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
        require("mini.sessions").write(name, { force = true })
    end,
})
