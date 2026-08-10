return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Enable treesitter highlighting
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
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
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- Enable treesitter indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"c",
				"lua",
				"vim",
				"javascript",
				"typescript",
				"html",
				"rust",
			},
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
