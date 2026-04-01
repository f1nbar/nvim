require("codeium").setup({
    -- Optionally disable cmp source if using virtual text only
    -- tools = {
    -- language_server = "/absolute/path/to/language_server_<os>_<arch>" },
    enable_cmp_source = false,
    virtual_text = {
        enabled = false,
    }
})
