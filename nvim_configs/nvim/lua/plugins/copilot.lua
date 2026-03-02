return {
    "https://github.com/github/copilot.vim",
    config = function ()
        -- disable copilot by default
        vim.g.copilot_enabled = false
        vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end
}
