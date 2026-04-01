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

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

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
    end,
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true, -- turn this ON for debugging
    float = { border = "rounded" },
    severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
