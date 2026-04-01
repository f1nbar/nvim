local M = {}

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
  return
end

mason.setup()

local servers = {
  "lemminx",
  "groovyls",
  "yamlls",
  "lua_ls",
  "bashls",
  "ts_ls",  -- use ts_ls instead of tsserver
  "tflint",
  "ltex",
  "pyright",
  "jsonls",
  "yaml-language-server",
  "helm-ls"
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local function setup_diagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- Capabilities for nvim-cmp integration
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('blink.cmp').get_lsp_capabilities(M.capabilities)

-- Optional navic integration
local function attach_navic(client, bufnr)
  -- Make sure navic is installed
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

-- on_attach runs when language server attaches to a buffer
M.on_attach = function(client, bufnr)
  -- Attach navic if available
  attach_navic(client, bufnr)

  -- Setup buffer keymaps for common LSP functions
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local keymap = vim.keymap.set
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  keymap("n", "]d", vim.diagnostic.goto_next, opts)
  keymap("n", "<leader>f", vim.lsp.buf.format, opts)

  -- Optional: disable formatting from specific clients, if needed e.g. ts_ls
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

-- Load optional server-specific settings
local function load_server_settings(server_name)
  local ok, settings = pcall(require, "finbar.lsp.settings." .. server_name)
  if ok then
    return settings
  else
    return {}
  end
end

for _, server in ipairs(servers) do
  local opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
  local server_settings = load_server_settings(server)

  -- opts = vim.tbl_deep_extend("force", opts, server_settings)

  -- vim.lsp.enable(server)
    
end

-- Format-on-save helper functions:
function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
    augroup END
  ]])
  vim.notify("Enabled format on save")
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.java",
  callback = function()
    vim.fn.jobstart("cd " .. vim.fn.getcwd() .. " && ./gradlew spotlessApply", {
      detach = true
    })
  end,
})

function M.disable_format_on_save()
  if vim.fn.exists("#format_on_save#BufWritePre") == 1 then
    vim.cmd("au! format_on_save")
  end
  vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
  if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

-- Run one time diagnostic setup
setup_diagnostics()

vim.g.python3_host_prog = vim.fn.system('uv run which python'):gsub('\n', '')

return M
