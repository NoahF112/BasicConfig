return {
    'stevearc/aerial.nvim',
    opts = {},
    keys = {
        { '<leader>a', '<cmd>AerialToggle!<CR>', mode = 'n', desc = 'Toggle Aerial outline' },
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
