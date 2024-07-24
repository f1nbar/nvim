return {
    settings = {
        java = {
            settings = {
                java = {
                    -- jdt = {
                    --     ls = {
                    --         vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m --add-modules=ALL-SYSTEM --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED -javaagent:/home/finbar/.config/nvim/dependencies/lombok.jar"
                    --     }
                    -- },
                    -- eclipse = {
                    --     downloadSources = true,
                    -- },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                        runtimes = {
                            {
                                name = "JavaSE-11",
                                path = "/usr/lib/jvm/zulu11/",
                                default = true,
                            },
                        },
                    },
                    --             maven = {
                    --                 downloadSources = true,
                    --             },
                    --             implementationsCodeLens = {
                    --                 enabled = true,
                    --             },
                    --             referencesCodeLens = {
                    --                 enabled = true,
                    --             },
                    --             references = {
                    --                 includeDecompiledSources = true,
                    --             },
                    --             inlayHints = {
                    --                 parameterNames = {
                    --                     enabled = "all", -- literals, all, none
                    --                 },
                    --             },
                    --             format = {
                    --                 enabled = true,
                    --                 settings = {
                    --                     profile = "google_java_format"
                    --                 }
                    --             },
                    --         },
                    --         signatureHelp = { enabled = true },
                    --         completion = {
                    --             favoriteStaticMembers = {
                    --                 "org.hamcrest.MatcherAssert.assertThat",
                    --                 "org.hamcrest.Matchers.*",
                    --                 "org.hamcrest.CoreMatchers.*",
                    --                 "org.junit.jupiter.api.Assertions.*",
                    --                 "java.util.Objects.requireNonNull",
                    --                 "java.util.Objects.requireNonNullElse",
                    --                 "org.mockito.Mockito.*",
                    --             },
                    --         },
                    --         contentProvider = { preferred = "fernflower" },
                    --         extendedClientCapabilities = extendedClientCapabilities,
                    --         sources = {
                    --             organizeImports = {
                    --                 starThreshold = 9999,
                    --                 staticStarThreshold = 9999,
                    --             },
                    --         },
                    --         codeGeneration = {
                    --             toString = {
                    --                 template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    --             },
                    --             useBlocks = true,
                    --         },
                    --     },
                    --
                    --     flags = {
                    --         allow_incremental_sync = true,
                    --     },
                    -- }
                }
            }
        }

