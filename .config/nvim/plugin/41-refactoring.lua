vim.pack.add({
    "https://github.com/lewis6991/async.nvim",
    "https://github.com/theprimeagen/refactoring.nvim",
})

vim.keymap.set({ "n", "x" }, "<leader>ri", function()
    return require("refactoring").inline_var()
end, { desc = "Inline Variable", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rI", function()
    return require("refactoring").inline_func()
end, { desc = "Inline function", expr = true })

vim.keymap.set({ "n", "x" }, "<leader>re", function()
    return require("refactoring").extract_func()
end, { desc = "Extract Function", expr = true })
-- `_` is the default textobject for "current line"
vim.keymap.set("n", "<leader>ree", function()
    return require("refactoring").extract_func() .. "_"
end, { desc = "Extract Function (line)", expr = true })
-- Use rf?
vim.keymap.set({ "n", "x" }, "<leader>rE", function()
    return require("refactoring").extract_func_to_file()
end, { desc = "Extract Function To File", expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rv", function()
    return require("refactoring").extract_var()
end, { desc = "Extract Variable", expr = true })
-- `_` is the default textobject for "current line"
vim.keymap.set("n", "<leader>rvv", function()
    return require("refactoring").extract_var() .. "_"
end, { desc = "Extract Variable (line)", expr = true })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
vim.keymap.set({ "x", "n" }, "<leader>rp", function()
    return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
end, { desc = "Debug print var below", expr = true })
vim.keymap.set({ "x", "n" }, "<leader>rpe", function()
    return require("refactoring.debug").print_exp({ output_location = "below" })
end, { desc = "Debug print exp below", expr = true })

vim.keymap.set({ "x", "n" }, "<leader>rc", function()
    return require("refactoring.debug").cleanup({ restore_view = true })
end, { desc = "Debug print clean", expr = true, remap = true })

-- local keymap = vim.keymap
--
-- keymap.set({ "n", "x" }, "<leader>rs", function()
--     return require("refactoring").select_refactor()
-- end, { desc = "Select refactor" })
--
-- -- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
-- keymap.set({ "x", "n" }, "<leader>pV", function()
--     return require("refactoring.debug").print_var({ output_location = "above" }) .. "iw"
-- end, { desc = "Debug print var above", expr = true })
--
-- -- `_` is the default textobject for "current line"
-- keymap.set("n", "<leader>pee", function()
--     return require("refactoring.debug").print_exp({ output_location = "below" }) .. "_"
-- end, { desc = "Debug print exp below", expr = true })
--
-- keymap.set({ "x", "n" }, "<leader>pE", function()
--     return require("refactoring.debug").print_exp({ output_location = "above" })
-- end, { desc = "Debug print exp above", expr = true })
-- -- `_` is the default textobject for "current line"
-- keymap.set("n", "<leader>pEE", function()
--     return require("refactoring.debug").print_exp({ output_location = "above" }) .. "_"
-- end, { desc = "Debug print exp above", expr = true })
--
-- keymap.set("n", "<leader>pP", function()
--     return require("refactoring.debug").print_loc({ output_location = "above" })
-- end, { desc = "Debug print location", expr = true })
-- keymap.set("n", "<leader>pp", function()
--     return require("refactoring.debug").print_loc({ output_location = "below" })
-- end, { desc = "Debug print location", expr = true })
