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

    function get_test_runner(test_name, debug)
        if debug then
            return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"' 
        end
        return 'mvn test -Dtest="' .. test_name .. '"' 
    end

    function run_java_test_method(debug)
        local utils = require'utils'
        local method_name = utils.get_current_full_method_name("\\#")
        vim.cmd('term ' .. get_test_runner(method_name, debug))
    end

    function run_java_test_class(debug)
        local utils = require'utils'
        local class_name = utils.get_current_full_class_name()
        vim.cmd('term ' .. get_test_runner(class_name, debug))
    end
end

