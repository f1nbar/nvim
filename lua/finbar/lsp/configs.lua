local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "lemminx", "metals", "groovyls", "tflint"}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("finbar.lsp.handlers").on_attach,
		capabilities = require("finbar.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "finbar.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
