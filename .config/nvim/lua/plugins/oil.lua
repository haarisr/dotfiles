return {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
    keys = {
        { "-", "<CMD>Oil<CR>", mode = "n", desc = "Open parent directory" },
    },
}
