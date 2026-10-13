local mason_ok, mason = pcall(require, "mason")
if mason_ok then
    mason.setup()
end

local format_group = vim.api.nvim_create_augroup("lsp-format", { clear = true })

local servers = {
    "bashls",
    "groovyls",
    "helm_ls",
    "jsonls",
    "lua_ls",
    "ltex",
    "pyright",
    "ruff",
    "terraformls",
    "tflint",
    "ts_ls",
    "yamlls",
}

local yaml_schemas = {
    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
    ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json"] = {
        "k8s/**/*.yaml",
        "k8s/**/*.yml",
        "**/kustomization.{yaml,yml}",
    },
    ["https://json.schemastore.org/chart.json"] = "**/Chart.yaml",
}

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
            format = { enable = false },
        },
    },
})

vim.lsp.config("pyright", {
    settings = {
        pyright = { disableOrganizeImports = true },
        python = { analysis = { autoImportCompletions = true, typeCheckingMode = "standard" } },
    },
})

vim.lsp.config("ruff", {
    init_options = { settings = { logLevel = "error" } },
})

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            schemas = yaml_schemas,
            validate = true,
            schemaStore = { enable = true },
            format = { enable = false },
        },
    },
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            validate = { enable = true },
            format = { enable = false },
            schemas = {
                { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
                { fileMatch = { "tsconfig.json", "tsconfig.*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
                { fileMatch = { ".prettierrc", ".prettierrc.json" }, url = "https://json.schemastore.org/prettierrc.json" },
            },
        },
    },
})

vim.lsp.config("helm_ls", {
    settings = {
        ["helm-ls"] = {
            yamlls = { path = "yaml-language-server" },
            logLevel = "error",
            format = { enable = false },
        },
    },
})

vim.lsp.config("ltex", {
    settings = {
        ltex = {
            language = "en-US",
            enabled = { "bibtex", "context", "git-commit", "markdown", "org", "rst", "tex", "text" },
        },
    },
})

vim.lsp.config("terraformls", { filetypes = { "terraform", "terraform-vars" } })
vim.lsp.config("tflint", { filetypes = { "terraform" } })

local ok, blink_caps = pcall(function()
    return require("blink.cmp").get_lsp_capabilities()
end)
local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    ok and blink_caps or {}
)

vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)

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
        local formatters = {
            python = { ruff = true },
        }
        local filetype = vim.bo[event.buf].filetype
        if client and formatters[filetype] and formatters[filetype][client.name] then
            vim.api.nvim_clear_autocmds({ group = format_group, buffer = event.buf })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = format_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = event.buf,
                        async = false,
                        filter = function(format_client)
                            return format_client.name == client.name
                                and format_client.supports_method("textDocument/formatting")
                        end,
                    })
                end,
            })
        end
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    float = { border = "rounded" },
    severity_sort = true,
})

vim.o.winborder = "rounded"
