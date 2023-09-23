local status_ok, telescope = pcall(require, "compiler")
if not status_ok then
  return
end

require("compiler").setup {
    cmd = {"CompilerOpen", "CompilerToggleResults"},
    opts = {
        -- Tasks are disposed 5 minutes after running to free resources.
        -- If you need to close a task inmediatelly:
        -- press ENTER in the menu you see after compiling on the task you want to close.
        task_list = {
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
            bindings = {
                ["q"] = function() vim.cmd("OverseerClose") end ,
            },
        },
    },
}

require("overseer").setup {}
