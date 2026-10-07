local mason = require("mason")
mason.setup()

local servers = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "bashls",
    "yamlls",
    "jsonls",
    "lemminx",
    "groovyls",
    "tflint",
    "ltex",
    "helm_ls",
}

local ok, blink_caps = pcall(function() return require('blink.cmp').get_lsp_capabilities() end)
local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    ok and blink_caps or {}
)

vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.enable(servers)

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }
        local map = vim.keymap.set

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "K", vim.lsp.buf.hover, opts)

        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentFormattingProvider then
            -- Skip auto-format for JSON (use pre-commit hooks instead)
            if vim.fn.expand("%:e") ~= "json" then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = event.buf,
                    callback = function()
                        vim.lsp.buf.format({
                            bufnr = event.buf,
                            async = false,
                        })
                    end,
                })
            end
        end
    end,
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true, -- turn this ON for debugging
    float = { border = "rounded" },
    severity_sort = true,
})

vim.o.winborder = "rounded"
