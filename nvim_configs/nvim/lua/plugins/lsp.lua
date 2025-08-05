return {
	-- mason for install Language Server Protocol
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- for lua
					"rust_analyzer", -- for rust
					"ast_grep", -- for c/cpp, rust
					"julials", -- for julia
					"ltex", -- for latex
					"matlab_ls", -- for latex
					"clangd", -- for c and c plus plus
					-- "typst_lsp", -- for typst
					-- "pylsp", -- for python
					-- "vhdl_ls", -- for vhdl/verilog
				},
			})
		end,
	},
	{
		"https://github.com/neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						-- diagnostics = {
						--     globals = {"vim"},
						-- },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- 添加 Neovim 的运行时路径
						},
					},
				},
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index", -- Enable background indexing
					"--clang-tidy", -- Enable clang-tidy diagnostics
					"--header-insertion=never", -- Don't auto-insert headers
				},
				root_dir = lspconfig.util.root_pattern(".nvim/compile_commands.json", ".git"),
			})
            -- lspconfig.pyright.setup({
			-- 	capabilities = capabilities,
			-- })
            lspconfig.pylsp.setup({
				capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = true,
                                ignore = {"E501"}
                            }
                        }
                    }
                }
			})
			lspconfig.julials.setup({
				capabilities = capabilities,
				julia_env_path = "/home/liwei/.juliaup/bin/julia",
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
			})
			-- lspconfig.ltex.setup({
			-- 	capabilities = capabilities,
			-- })
			lspconfig.texlab.setup({
				capabilities = capabilities,
			})
			lspconfig.ast_grep.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				-- Server-specific settings. See `:help lspconfig-setup`
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {},
				},
			})
			-- lspconfig.eslint.setup({
			-- 	on_attach = function(client, bufnr)
			-- 		-- disabele formmater
			-- 		client.server_capabilities.documentFormattingProvider = false
			-- 	end,
			-- 	capabilities = capabilities,
			-- })
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				-- on_attach = function(client, bufnr)
				-- 	-- 禁用 tsserver 格式化功能，避免与其他格式化工具冲突（如 Prettier）
				-- 	client.server_capabilities.documentFormattingProvider = false
				-- end,
				-- capabilities = capabilities, -- 支持 nvim-cmp
			})
			lspconfig.tinymist.setup({
				capabilities = capabilities,
			})
			-- lspconfig.hdl_checker.setup({
			--     capabilities=capabilities
			-- })
			lspconfig.verible.setup({
				cmd = {
					"verible-verilog-ls",
					"verible-verilog-format",
				},
				--  capabilities = capabilities,
			})
			vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
