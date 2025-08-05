vim.cmd("set number")
vim.cmd("set relativenumber")

-- vim.cmd("set clipboard=unnamedplus")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set spc=")
vim.cmd("set iskeyword-=_")
vim.cmd("syntax on")
vim.o.termguicolors = true

vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "FileTypeIndent",
	pattern = "python",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "FileTypeIndent",
	pattern = { "c", "cpp", "java", "html", "javascript", "typst" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = true
	end,
})

local function ensure_nvim_folder()
	local cwd = vim.fn.getcwd()
	local nvim_folder = cwd .. "/.nvim"
	local template_file = vim.fn.stdpath("config") .. "/template/snippets.lua"
	local target_file = cwd .. "/.nvim/snippets.lua"

	if vim.fn.isdirectory(cwd) == 1 and vim.fn.isdirectory(nvim_folder) == 0 then
		vim.fn.mkdir(nvim_folder, "p")
		print(".nvim created")

		if vim.fn.filereadable(template_file) == 1 then
			vim.fn.writefile(vim.fn.readfile(template_file), target_file)
			print("Template snippets.lua copied to" .. target_file)
		else
			print("Template file " .. template_file .. " not found")
		end

		local fd, err = vim.loop.fs_open(cwd .. "/.nvim/.tasks", "w", 420)
		if not fd then
			print("Error creating .tasks file: " .. err)
		else
			vim.loop.fs_close(fd)
			print("Successfully created ./nvim/.tasks")
		end
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 1 then
			local arg = vim.fn.argv(0) -- get first arg
			if vim.loop.fs_stat(arg) and vim.fn.isdirectory(arg) == 1 then
				-- only execute when opening a directory
				ensure_nvim_folder()
			end
		end
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "tex",
-- 	callback = function(args)
-- 		vim.treesitter.start(args.buf, "latex")
-- 		vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
-- 	end,
-- })

-- vim.api.nvim_create_autocmd(
--     "BufWritePost", --event
--     {
--         pattern = "snippets.lua",
--         callback = function ()
--             local cwd = vim.fn.getcwd()
--             dofile(cwd.."/.nvim/snippets.lua") -- reload snippets
--             print("Reload snippets.lua!")
--         end
--     }
-- )
