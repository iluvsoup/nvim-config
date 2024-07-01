vim.g.mapleader = " "
vim.keymap.set("n", "<leader>k", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "x" }, "<Tab>", ">")
vim.keymap.set({ "n", "x" }, "<S-Tab>", "<")
vim.keymap.set("n", "<Tab><Tab>", ">>")
vim.keymap.set("n", "<S-Tab><S-Tab>", "<<")

-- map alt+enter to new line above
vim.keymap.set("i", "<a-CR>", "<Esc>O")

vim.api.nvim_create_autocmd('filetype', {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
        end

        -- Pressing enter is akward
        bind("<leader>j", "<Enter>")
        bind("<leader>k", "-")

        bind("n", "%")
        bind("r", "R")
    end
})

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")

-- use ctrl+[hjlk] to switch between splits
vim.keymap.set("n", "<C-h>", ":wincmd h<Enter>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<Enter>", { silent = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<Enter>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<Enter>", { silent = true })
