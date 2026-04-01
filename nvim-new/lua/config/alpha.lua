local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")
local pick = require("mini.pick")

---------------------------------------------------
-- Header
---------------------------------------------------

dashboard.section.header.val = {
    [[ ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ]],
    [[ ████╗  ██║██║   ██║██║████╗ ████║ ]],
    [[ ██╔██╗ ██║██║   ██║██║██╔████╔██║ ]],
    [[ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
    [[ ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
    [[ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
}

---------------------------------------------------
-- Buttons
---------------------------------------------------

dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", function()
        pick.builtin.files()
    end),

    dashboard.button("g", "  Find text", function()
        pick.builtin.grep()
    end),

    dashboard.button("b", "  Buffers", function()
        pick.builtin.buffers()
    end),

    dashboard.button("h", "  Help", function()
        pick.builtin.help()
    end),

    dashboard.button("r", "  Recent files", function()
        local files = vim.tbl_filter(function(f)
            return vim.fn.filereadable(f) == 1
        end, vim.v.oldfiles)

        pick.start({
            source = {
                name = "Recent Files",
                items = files,
            },
        })
    end),

    -- dashboard.button("s", "󰁯  Sessions", function()
    --     require("mini.sessions").select()
    -- end),

    dashboard.button("q", "  Quit", ":qa<CR>"),
}

---------------------------------------------------
-- Layout
---------------------------------------------------

dashboard.section.header.opts.position = "center"
dashboard.section.buttons.opts.position = "center"

dashboard.opts.layout = {
    { type = "padding", val = 5 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
}

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
