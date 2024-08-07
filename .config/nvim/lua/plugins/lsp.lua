return {
    'neovim/nvim-lspconfig', -- Required
    dependencies = {
        -- LSP Support
        'williamboman/mason.nvim',           -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional

        -- Autocompletion
        'hrsh7th/nvim-cmp',         -- Required
        'hrsh7th/cmp-nvim-lsp',     -- Required
        'hrsh7th/cmp-buffer',       -- Optional
        'hrsh7th/cmp-path',         -- Optional
        'saadparwaiz1/cmp_luasnip', -- Optional
        'hrsh7th/cmp-nvim-lua',     -- Optional

        -- Snippets
        'L3MON4D3/LuaSnip',             -- Required
        'rafamadriz/friendly-snippets', -- Optional
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "bashls",
                "jsonls",
                "rust_analyzer",
                "tsserver",
                "html",
                "lua_ls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    require("neodev").setup({
                        library = { plugins = { "nvim-dap-ui" }, types = true },
                    })
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim",
                                        "it",
                                        "describe",
                                        "before_each",
                                        "after_each"
                                    },

                                }
                            }
                        }
                    }
                end,
                ["omnisharp"] = function()
                    local lspconfig = require("lspconfig")
                    local pid = vim.fn.getpid()
                    local omnisharp_bin = "~/.local/share/lazy/mason/packages/omnisharp/omnisharp"

                    lspconfig.omnisharp.setup {
                        capabilities = capabilities,
                        cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
                        filetypes = { "cs", "vb" },
                        root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),

                        enable_ms_build_load_projects_on_demand = true,
                        enable_roslyn_analyzers = true,
                        enable_import_completion = true,
                        analyze_open_documents_only = false,
                        enable_editorconfig_support = true,
                    }
                end,
                ["tsserver"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tsserver.setup {
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    }
                end
            },
        })
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })

        })

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}
