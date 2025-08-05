require("vim-opertion")
require("lazy-config")
require("spell_checker")


-- Setup lazy.nvim

require("lazy").setup("plugins")



-- Set nvim background to be transparent and can see the background of terminal

vim.opt.termguicolors = true

vim.cmd [[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi LineNr guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]]


-- keymap
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "H", "^", { noremap = true, silent = true })
vim.keymap.set("n", "K", "i<CR><Esc>k$", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>t', ':exe "normal! 2\\<C-y>"<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>t', ':lua vim.fn.winrestview({topline = vim.fn.line(".") - 2})<CR>', { noremap = true, silent = true, desc = "Set current line to be the third line of this screen" })


for i = 1,9 do
    vim.api.nvim_set_keymap(
        'n',
        "<C-"..i..">",
        ":tabnext "..i..'<CR>',
        {noremap = true, silent = true}
    )
end

-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = {'verilog', 'systemverilog'},
  callback = function()
    vim.lsp.start({
      name = 'verible',
      cmd = {'verible-verilog-ls', '--rules_config_search'},
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.v",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

vim.diagnostic.config({
    virtual_text = true,  -- 显示虚拟文本
    signs = true,         -- 显示左侧标记
    update_in_insert = false,
    underline = true,     -- 显示下划线
    severity_sort = true,
})
