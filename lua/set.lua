vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- disable auto comment on new line
--[[
From :help fo-table:

You can use the 'formatoptions' option  to influence how Vim formats text.
'formatoptions' is a string that can contain any of the letters below.  The
default setting is "tcq".  You can separate the option letters with commas for
readability.

letter  meaning when present in 'formatoptions'

t       Auto-wrap text using textwidth
c       Auto-wrap comments using textwidth, inserting the current comment
        leader automatically.
r       Automatically insert the current comment leader after hitting
        <Enter> in Insert mode.
o       Automatically insert the current comment leader after hitting 'o' or
        'O' in Normal mode.
...
--]]

-- vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) -- This didn't work
-- these two are probably identical but who cares
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. ".vim/undodir"
vim.opt.undofile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- No idea what this does
vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true
