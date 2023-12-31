return {
    'nvim-telescope/telescope.nvim',
    lazy = false, -- didn't wanna bother
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}
