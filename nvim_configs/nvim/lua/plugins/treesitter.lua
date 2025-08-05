return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"typescript",
				"html",
				"markdown",
				"markdown_inline",
				"rust",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			additional_vim_regex_highlighting = false,
			spellcheck = {
				enable = true,
				query = [[
                    (comment) @spell
                    (string) @spell
                    (documentation) @spell
                ]],
			},
		})
	end,
}
