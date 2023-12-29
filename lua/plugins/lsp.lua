local formatting_servers = {
    ['lua_ls'] = { 'lua' },
}

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require('mason').setup({
                ui = {
                    border = 'rounded',
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-space>'] = cmp.mapping.complete(),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder",
                    }),
                },
                sources = cmp.config.sources({
                    { name = 'path' },
                    {
                        name = "nvim_lsp",
                        -- remove text suggestions
                        entry_filter = function(entry, ctx)
                            return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
                        end
                    },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                }),
                enabled = function()
                    -- disable completion in comments
                    local context = require 'cmp.config.context'
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })

                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr, remap = false }

                -- telescope is nice
                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)

                -- don't really need this since i can use telescope
                -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                --[[ defaults provided by lsp-zero
                     k: displays hover information about the symbol under the cursor in a floating window. see :help vim.lsp.buf.hover().
                     gd: jumps to the definition of the symbol under the cursor. see :help vim.lsp.buf.definition().
                     gd: jumps to the declaration of the symbol under the cursor. some servers don't implement this feature. see :help vim.lsp.buf.declaration().
                     gi: lists all the implementations for the symbol under the cursor in the quickfix window. see :help vim.lsp.buf.implementation().
                     go: jumps to the definition of the type of the symbol under the cursor. see :help vim.lsp.buf.type_definition().
                     gr: lists all the references to the symbol under the cursor in the quickfix window. see :help vim.lsp.buf.references().
                     gs: displays signature information about the symbol under the cursor in a floating window. see :help vim.lsp.buf.signature_help(). if a mapping already exists for this key this function is not bound.
                     <f2>: renames all references to the symbol under the cursor. see :help vim.lsp.buf.rename().
                     <f3>: format code in current buffer. see :help vim.lsp.buf.format().
                     <f4>: selects a code action available at the current cursor position. see :help vim.lsp.buf.code_action().
                     gl: show diagnostics in a floating window. see :help vim.diagnostic.open_float().
                     [d: move to the previous diagnostic in the current buffer. see :help vim.diagnostic.goto_prev().
                     ]d: move to the next diagnostic. see :help vim.diagnostic.goto_next().
                ]]
            end)

            lsp_zero.format_mapping('<leader>f', {
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = formatting_servers
            })

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = formatting_servers
            })

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- define a custom function in order to configure the language server
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    }
}
