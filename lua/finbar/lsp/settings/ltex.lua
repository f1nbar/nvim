return {
  filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      language = "en-GB"
    }
  },
  on_attach = on_attach,
}
