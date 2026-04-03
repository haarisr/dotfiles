vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

local get_project_root = function()
    return fzf.path.git_root({}, true) or fzf.path.jj_root({}, true) or vim.loop.cwd()
end

fzf.setup({
    "skim",
    grep = {
        hidden = true,
    },
})
vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "Find [P]roject [F]iles" })
vim.keymap.set("n", "<C-p>", fzf.vcs_files, { desc = "[P]roject VCS files (git/jj)" })
vim.keymap.set("n", "<leader>ps", function()
    fzf.grep({ cwd = get_project_root() })
end, { desc = "[P]roject [S]earch" })
vim.keymap.set("n", "<leader>vh", fzf.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>?", fzf.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sw", function()
    fzf.grep_cword({ cwd = get_project_root() })
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", function()
    fzf.live_grep({ cwd = get_project_root() })
end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>.", function()
    fzf.files({ cwd = vim.fn.expand("%:h") })
end, { desc = "Find [.] files in current directory" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find [f]iles in [B]uffer" })
