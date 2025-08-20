local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

local java = require("neotest-java")

neotest.setup({
  summary = {
      open = "botright vsplit | vertical resize 80",
  },
  adapters = {
      java({  
         incremental_build = false,
      }),
  },
})
