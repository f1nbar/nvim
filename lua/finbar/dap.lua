local dap, dapui = require("dap"), require("dapui")
require("dapui").setup()
require('dap.ext.vscode').load_launchjs()

config = function()
  dap.defaults.fallback.terminal_win_cmd = 'tabnew'

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end
