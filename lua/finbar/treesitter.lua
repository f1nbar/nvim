local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end
require('ts_context_commentstring').setup()

configs.setup {
    ensure_installed = {"java", "scala", "lua", "python", "rust", "go", "c"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false , -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = true,
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
  --[[   context_commentstring = { ]]
  --[[       enable = true, ]]
  --[[       enable_autocmd = false, ]]
  --[[ }, ]]
    refactor = {
        smart_rename = {
            highlight_current_scope = { enable = true },
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
            keymaps = {
                smart_rename = "grr",
            },
        },
        navigation = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    },
}

