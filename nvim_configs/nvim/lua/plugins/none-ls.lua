return {
	"https://github.com/nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.typstfmt,
				-- null_ls.builtins.completion.spell,
				-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
                null_ls.builtins.formatting.prettier.with({
                    extra_args = {"--tab-width", "2", "--use-tabs", "false"}
                }),
                -- null_ls.builtins.formatting.verible,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        vim.keymap.set('n', '<leader>fl', function()
            local start_pos = vim.api.nvim_win_get_cursor(0)
            vim.lsp.buf.format({ range = {
                start = { start_pos[1], 0 },
                ['end'] = { start_pos[1], math.huge }
            }})
        end, { desc = "Format current line" })
	end,
}
