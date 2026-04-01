require("sidekick").setup({
    cli = {
        mux = {
            backend = "zellij",
            enabled = true,
        },
    },
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>Cc", function()
    require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Toggle Claude" })
