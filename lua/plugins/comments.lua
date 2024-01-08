return {
    {
        'numToStr/Comment.nvim',
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = '\\\\',
                ---Block-comment toggle keymap
                block = '||',
            },
            opleader = {
                ---Line-comment keymap
                line = '\\',
                ---Block-comment keymap
                block = '|',
            },
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = false,
            },
        }
    }
}
