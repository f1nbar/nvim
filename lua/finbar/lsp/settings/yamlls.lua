return {
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        {
          fileMatch = { ".yaml", ".yml" },
        }
      },
      format = {
        enable = true,
      },
      validate = true,
      completion = true
    }
  }
}
