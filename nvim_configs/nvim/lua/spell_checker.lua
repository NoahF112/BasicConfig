local function set_project_dictionary()
    local project_path = vim.fn.getcwd()                   -- Get the current project directory
    local dict_file = project_path .. "/.nvim/dictionary.add" -- Path to the project's dictionary file

    -- Check if the dictionary file exists
    if vim.fn.filereadable(dict_file) == 0 then
        -- If it doesn't exist, create the file
        local file = io.open(dict_file, "w")
        if file then
            file:close()
            print("Created project dictionary: " .. dict_file)
            -- Set the spellfile to the dictionary file
            vim.opt_local.spellfile = dict_file
        else
            print("Error: Unable to create dictionary file at " .. dict_file)
            print("Use the default dictionary file to check")
        end
    else
        vim.opt_local.spellfile = dict_file
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "typst" }, -- Specify filetypes here
    callback = function()
        vim.opt_local.spell = true   -- Enable spell checking
        vim.opt_local.spelllang = "en,cjk,de_20" -- Set the default spell language
        --        if vim.fn.argc() == 1 then
        --            local arg = vim.fn.argv(0) -- get first arg
        --            if vim.loop.fs_stat(arg) and vim.fn.isdirectory(arg) == 1 then
        set_project_dictionary()
        --            else
        --                print("Use default dictionary to check")
        --            end
        --      end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "python", "rust" }, -- Specify filetypes here
    callback = function()
        vim.opt_local.spell = true           -- enable spell checking by default
        -- spell checking automatically enabled at comments and strings
        -- see plugin/treesitter.lua
        vim.opt_local.spelllang = "en,cjk" -- Set the default spell language
        set_project_dictionary()
    end,
})
