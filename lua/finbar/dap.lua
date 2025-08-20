local dap, dapui = require("dap"), require("dap-view")
require("dap-view").setup()
require('dap.ext.vscode').load_launchjs()

config = function()
  dap.defaults.fallback.terminal_win_cmd = 'tabnew'

    dap.configurations.java = {
        {
            -- -- You need to extend the classPath to list your dependencies.
            -- -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
            -- classPaths = {},
            --
            -- -- If using multi-module projects, remove otherwise.
            -- projectName = "yourProjectName",
            --
            -- javaExec = "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/bin/java",
            -- mainClass = "your.package.name.MainClassName",
            --
            -- -- If using the JDK9+ module system, this needs to be extended
            -- -- `nvim-jdtls` would automatically populate this property
            -- modulePaths = {},
            -- name = "Launch YourClassName",
            -- request = "launch",
            -- type = "java"
        },
    }

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

