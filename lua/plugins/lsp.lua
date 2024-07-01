local formatting_servers = {
    ['lua_ls'] = { 'lua' },
    ['gopls'] = { "go", "gomod", "gowork", "gotmpl" }
}

--[[ local source_strings = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    nvim_lua = "[Lua]",
    latex_symbols = "[LaTeX]",
} ]]

local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
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
            { 'nvim-tree/nvim-web-devicons' },
            {
                'windwp/nvim-autopairs',
                config = true,
            },
        },
        config = function()
            do
                -- Customization for Pmenu
                vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
                vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

                vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
                vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
                vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
                vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

                --[[ vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
                vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
                vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

                vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
                vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
                vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

                vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
                vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
                vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

                vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
                vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
                vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
                vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
                vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

                vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
                vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

                vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
                vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
                vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

                vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
                vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
                vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

                vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
                vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
                vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" }) ]]
            end

            local devicons = require('nvim-web-devicons')

            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

            vim.cmd("set pumheight=20")

            -- Maybe disable, it's kinda ass
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },

                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder",
                        -- winhighlight = "FloatBorder:Pmenu",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder",
                    }),
                },

                -- formatting = lsp_zero.cmp_format(),
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ 'path' }, entry.source.name) then
                            local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end

                        local kind = vim_item.kind
                        if kind == nil then
                            vim_item.menu = ""
                        else
                            vim_item.menu = "   (" .. kind .. ")" --.. source_strings[entry.source.name]
                        end

                        vim_item.kind = kind_icons[kind]

                        return vim_item
                    end

                    --[[ fields = { 'abbr', 'kind', 'menu' },
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ 'path' }, entry.source.name) then
                            local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end

                        vim_item.kind = string.format("%s %s", vim_item.kind, kind_icons[vim_item.kind])
                        -- vim_item.menu = source_strings[entry.source.name]
                        vim_item.menu = ""

                        return vim_item
                    end ]]
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-space>'] = cmp.mapping.complete({ select = true }),

                    ['<C-p>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = 'insert' })
                        else
                            cmp.complete({ select = true })
                        end
                    end),
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = 'insert' })
                        else
                            cmp.complete({ select = true })
                        end
                    end),

                    ['<C-e>'] = cmp.mapping.abort(),

                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),

                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
                }),

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
                ensure_installed = { 'lua_ls', 'gopls' },
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
