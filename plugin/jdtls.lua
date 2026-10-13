local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
local cache_vars = {}

local root_files = {
    '.git',
    'pom.xml',
    'mvnw',
    'build.gradle',
    'build.gradle.kts',
    'gradlew',
    'settings.gradle',
    'settings.gradle.kts',
}

local features = {
    -- change this to `true` to enable codelens
    codelens = true,

    -- change this to `true` if you have `nvim-dap`,
    -- `java-test` and `java-debug-adapter` installed
    debugger = true,
}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}
    path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

    local registry = require('mason-registry')
    if not registry.is_installed('jdtls') then
        error('JDTLS is not installed. Install it with :MasonInstall jdtls.')
    end

    local function package_path(name)
        return vim.fn.stdpath('data') .. '/mason/packages/' .. name
    end

    local jdtls_install = package_path('jdtls')

    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end

    path.bundles = {}

    if registry.is_installed('java-test') then
        path.java_test_available = false
        local java_test_path = package_path('java-test')

        local java_test_bundle = vim.fn.glob(java_test_path .. '/extension/server/*.jar', false, true)
        vim.list_extend(path.bundles, java_test_bundle)
        path.java_test_available = #java_test_bundle > 0
    end

    ---
    -- Include java-debug-adapter bundle if present
    ---
    if registry.is_installed('java-debug-adapter') then
        path.java_debug_available = false
        local java_debug_path = package_path('java-debug-adapter')

        local java_debug_bundle = vim.fn.glob(
            java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar',
            false,
            true
        )
        vim.list_extend(path.bundles, java_debug_bundle)
        path.java_debug_available = #java_debug_bundle > 0
    end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---
    path.runtimes = {
        -- Note: the field `name` must be a valid `ExecutionEnvironment`,
        -- you can find the list here:
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request

        -- {
        --     name = 'JavaSE-11',
        --     path = '/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home/'
        -- },
        -- {
        --     name = 'JavaSE-17',
        --     path = '/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home/'
        -- },

    }

    cache_vars.paths = path

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = bufnr,
        group = java_cmds,
        desc = 'refresh codelens',
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(path)
    if not features.debugger or not path.java_test_available or not path.java_debug_available then
        return
    end
    local dap_ok = pcall(require, 'dap')
    if not dap_ok then
        return
    end
    local jdtls = require('jdtls')
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
    local jdtls = require('jdtls')
    local opts = { buffer = bufnr, silent = true }
    local function call(name, ...)
        if type(jdtls[name]) ~= 'function' then
            return nil
        end
        local args = { ... }
        return function() jdtls[name](unpack(args)) end
    end
    local function map(mode, lhs, name, ...)
        local action
        if name == 'code_lens.run' then
            action = function() vim.lsp.codelens.run() end
        elseif name == 'code_lens.refresh' then
            action = function() vim.lsp.codelens.refresh() end
        else
            action = call(name, ...)
        end
        if action then vim.keymap.set(mode, lhs, action, opts) end
    end

    local path = cache_vars.paths
    if path then enable_debugger(path) end
    if features.codelens and client.server_capabilities.codeLensProvider then
        enable_codelens(bufnr)
        map('n', '<leader>cl', 'code_lens.run')
        map('n', '<leader>cr', 'code_lens.refresh')
    end

    map('n', '<leader>tc', 'test_class')
    map('n', '<leader>tn', 'test_nearest_method')
    map('n', '<leader>tf', 'test_file')
    map('n', '<leader>oi', 'organize_imports')
    map('n', '<leader>ev', 'extract_variable')
    map('x', '<leader>ev', 'extract_variable', true)
    map('n', '<leader>ec', 'extract_constant')
    map('x', '<leader>ec', 'extract_constant', true)
    map('x', '<leader>em', 'extract_method', true)
    map('n', '<leader>cp', 'compile')
    map('n', '<leader>up', 'update_project_config')
    map('n', '<leader>cf', 'javap')
    if vim.lsp.inlay_hint then
        vim.keymap.set('n', '<leader>ih', function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
        end, opts)
    end
end

local function jdtls_setup()
    local jdtls = require('jdtls')
    local extendedClientCapabilities = jdtls.extendedClientCapabilities;
    extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

    local path = get_jdtls_paths()
    local root_dir = vim.fs.root(0, root_files) or vim.fn.getcwd()
    root_dir = vim.fn.fnamemodify(root_dir, ':p'):gsub('/+$', '')
    local project_key = vim.fn.sha256(root_dir):sub(1, 16)
    local data_dir = path.data_dir .. '/' .. project_key
    path.debug_bundles = path.debug_bundles or {}
    for _, bundle in ipairs(path.bundles) do
        if bundle:find('com.microsoft.java.debug.plugin', 1, true) then
            table.insert(path.debug_bundles, bundle)
        end
    end

    if cache_vars.capabilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
        local ok_blink, blink_caps = pcall(function()
            return require('blink.cmp').get_lsp_capabilities()
        end)
        cache_vars.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            ok_blink and blink_caps or {}
        )
    end

    local java_home = vim.fn.getenv('JAVA_HOME')
    if java_home == '' and vim.fn.has('mac') == 1 then
        java_home = vim.fn.system('/usr/libexec/java_home'):gsub('%s+$', '')
    end

    local java_executable = java_home ~= '' and (java_home .. '/bin/java') or vim.fn.exepath('java')
    if java_executable == '' then
        error('JDTLS requires Java. Set JAVA_HOME or add java to PATH.')
    end

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    local cmd = {
        java_executable,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path.java_agent,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar',
        path.launcher_jar,

        -- 💀
        '-configuration',
        path.platform_config,

        -- 💀
        '-data',
        data_dir,
    }

    local lsp_settings = {
        java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            project = {
                outputPath = "build/classes/java/main",
                referencedLibraries = {
                    -- add any library jars here for the lsp to pick them up
                },
            },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = path.runtimes,
                maven = {
                    userSettings = vim.fn.expand('~/.m2/settings.xml')
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                enabled = true,
                --parameterNames = {
                --   enabled = 'all' -- literals, all, none
                --}
            },
            format = {
                enabled = true, -- TODO, do we want this or null-ls
                settings = {
                    url = 'https://google.github.io/styleguide/intellij-java-google-style.xml',
                },
            }
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
        },
        contentProvider = {
            preferred = 'fernflower',
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            }
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    jdtls.start_or_attach({
        cmd = cmd,
        settings = lsp_settings,
        on_attach = function(client, bufnr)
            jdtls_on_attach(client, bufnr)
        end,
        capabilities = cache_vars.capabilities,
        root_dir = root_dir,
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
            extendedClientCapabilities = extendedClientCapabilities,
            settings = {
                java = {
                    implementationsCodeLens = { enabled = true },
                    imports = {
                        gradle = {
                            enabled = true,
                            wrapper = {
                                enabled = true,
                            },
                            annotationProcessing = {
                                enabled = true,
                            }
                        },
                    },
                },
            },
        },
    })
end

vim.api.nvim_create_autocmd('FileType', {
    group = java_cmds,
    pattern = { 'java' },
    desc = 'Setup jdtls',
    callback = jdtls_setup,
})
