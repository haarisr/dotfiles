return {
    "mbbill/undotree",
    name = "undotree",
    config = function() end,
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, mode = "n", desc = "Undotree Toggle" },
    },
}
