-- herdr-nvim: annotations for the herdr nvim sidebar (ChmaraX/herdr-nvim).
-- Only active inside a herdr session; harmless elsewhere.
-- Sidebar toggle + file picker live on the herdr side (prefix+e / prefix+o).
if package.loaded["herdr-nvim"] or vim.api.nvim_get_runtime_file("lua/herdr-nvim/init.lua", true)[1] then
    local ok, herdr_nvim = pcall(require, "herdr-nvim")
    if ok then
        herdr_nvim.setup({
            prefix = "<leader>a",
            keymaps = true,
            clear_after_send = true,
        })
    end
end
