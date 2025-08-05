return {
    "https://github.com/ojroques/vim-oscyank",
    config = function ()
        vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
        vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
        vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')
    end
}
