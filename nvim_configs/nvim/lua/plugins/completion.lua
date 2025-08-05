return {
    {
        "https://github.com/hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer", -- 用于缓冲区补全
            -- "f3fora/cmp-spell", -- Used for spell
            "hrsh7th/cmp-path", -- 用于路径补全
            "hrsh7th/cmp-cmdline", -- 用于命令行补全
            "hrsh7th/cmp-nvim-lsp", -- LSP 补全
            "saadparwaiz1/cmp_luasnip", -- LuaSnip 代码片段补全
            "L3MON4D3/LuaSnip", -- 必须安装 Snippet 引擎
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<M-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- 选择下一项
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- 选择上一项
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", max_item_count = 8, keyword_length = 2  },
                    -- { name = "spell"},
                    -- { name = "vsnip" }, -- For vsnip users.
                    { name = "luasnip" }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = "buffer" },
                }),
            })

            -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
            -- Set configuration for specific filetype.
            --[[ cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                  { name = 'git' },
                }, {
                  { name = 'buffer' },
                })
             })
             require("cmp_git").setup() ]]
            --

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })

            -- Set up lspconfig.
            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -- require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
            --     capabilities = capabilities,
            -- })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local luasnip = require("luasnip")

            -- Function to load snippets from a project's `.nvim/snippets.lua` file
            local function load_project_snippets()
                local project_snippet_file = vim.fn.getcwd() .. "/.nvim/snippets.lua"

                if vim.fn.filereadable(project_snippet_file) == 1 then
                    dofile(project_snippet_file)
                    print("Loaded project snippets from: " .. project_snippet_file)
                else
                    print("No project snippets found for: " .. vim.fn.getcwd())
                end
            end

            -- Autocommand to load snippets when entering a directory
            vim.api.nvim_create_autocmd("DirChanged", {
                callback = load_project_snippets,
            })

            -- Initial load for the current directory
            load_project_snippets()
            vim.keymap.set("n", "<leader>ps", function()
                load_project_snippets()
                print("Project snippets reloaded")
            end, { desc = "Reload project snippets" })
        end,
    },
    {
        "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
}
