local terminalPattern = { "term://*#toggleterm#*", "term://*::toggleterm::*" }

return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")
            local terminal = require("toggleterm.terminal")

            local Terminal = terminal.Terminal

            toggleterm.setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                on_open = function(term)
                    term:set_mode(terminal.mode.INSERT)
                end,
                highlights = {
                    FloatBorder = {
                        link = "FloatBorder"
                    },
                },
                hide_numbers = true,
                close_on_exit = true,
                shell = vim.o.shell,
                start_in_insert = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })

            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*",
                callback = function()
                    local opts = { noremap = true }
                    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
                    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
                end
            })

            -- For example, "2<C-t>" will toggle the second terminal
            vim.keymap.set("n", "<C-t>", [[<cmd>exe v:count1 . "ToggleTerm"<CR>]])

            -- Automatically enter insert mode when entering terminal
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = terminalPattern,
                callback = function()
                    local _, term = terminal.identify()
                    if term == nil then return end
                    term:set_mode(terminal.mode.INSERT)
                end,
            })

            local function createTemporaryTerm(cmd, name)
                local deleted = false
                return Terminal:new({
                    cmd = cmd,
                    name = name,
                    hidden = true,
                    start_in_insert = true,
                    on_close = function(term)
                        if not deleted then
                            deleted = true -- preventing stack overflow because shutdown calls close
                            term:shutdown()
                            term = nil     -- unnecessary?
                        end
                    end
                })
            end

            vim.keymap.set("n", "<leader>tn", function()
                createTemporaryTerm("node", "JavaScript REPL"):open()
            end)

            vim.keymap.set("n", "<leader>tl", function()
                createTemporaryTerm("lua", "Lua REPL"):open()
            end)

            vim.keymap.set("n", "<leader>tb", function()
                createTemporaryTerm("btop", "Process Manager"):open()
            end)

            vim.keymap.set("n", "<leader>tt", function()
                createTemporaryTerm(nil, "Terminal"):open()
            end)

            vim.keymap.set("n", "<leader>th", function()
                Terminal:new({
                    direction = "horizontal",
                    name = "Terminal",
                    hidden = false,
                    start_in_insert = true,
                }):open()
            end)

            vim.keymap.set("n", "<leader>tv", function()
                Terminal:new({
                    direction = "vertical",
                    name = "Terminal",
                    hidden = false,
                    start_in_insert = true,
                }):open()
            end)
        end
    }
}
