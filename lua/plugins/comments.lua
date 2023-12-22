return {
    {
        'numToStr/Comment.nvim',
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = 'öö',
                ---Block-comment toggle keymap
                block = 'ÖÖ',
            },
            opleader = {
                ---Line-comment keymap
                line = 'ö',
                ---Block-comment keymap
                block = 'Ö',
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
