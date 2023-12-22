return {
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        config = function()
            require("kanagawa").setup({
                transparent = false,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
            })
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = true,
        config = function()
            require("rose-pine").setup({
                disable_background = false
            })
        end
    },
    { 'catppuccin/nvim',          name = 'catppuccin', lazy = true },
    -- { "morhetz/gruvbox", lazy = true },
    { "sainnhe/gruvbox-material", name = 'gruvbox',    lazy = true },
    { "folke/tokyonight.nvim",    lazy = true },
    { "sainnhe/sonokai",          lazy = true },
    { "AlexvZyl/nordic.nvim",     lazy = true },
    { "sainnhe/everforest",       lazy = true }
}
