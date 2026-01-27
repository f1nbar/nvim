return {
    vim.lsp.config("helm_ls", {
        cmd = { 'helm_ls', 'serve' },
        root_markers = { 'Chart.yaml', 'Finbar.yaml'},
        filetypes = { 'helm', 'yaml.helm-values' }
    })
}

