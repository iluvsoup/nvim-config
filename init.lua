local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("remap")
require("set")

require("lazy").setup("plugins", {
    ui = {
        border = "rounded", -- see https://neovim.io/doc/user/api.html#nvim_open_win() for border options
        title = "Lazy"
    }
})
