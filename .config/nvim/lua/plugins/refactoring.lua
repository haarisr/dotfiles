return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
        {
            "<leader>re",
            function()
                return require("refactoring").refactor("Extract Function")
            end,
            mode = "v",
            desc = "Extract Function",
            expr = true,
        },
        {
            "<leader>rf",
            function()
                return require("refactoring").refactor("Extract Function To File")
            end,
            mode = "v",
            desc = "Extract Function To File",
            expr = true,
        },
        {
            "<leader>rv",
            function()
                return require("refactoring").refactor("Extract Variable")
            end,
            mode = "v",
            desc = "Extract Variable",
            expr = true,
        },
        {
            "<leader>rb",
            function()
                return require("refactoring").refactor("Extract Block")
            end,
            mode = "n",
            desc = "Extract Block",
            expr = true,
        },
        {
            "<leader>rbf",
            function()
                return require("refactoring").refactor("Extract Block To File")
            end,
            mode = "n",
            desc = "Extract Block To File",
            expr = true,
        },
        {
            "<leader>ri",
            function()
                return require("refactoring").refactor("Inline Variable")
            end,
            mode = { "n", "x" },
            desc = "Inline Variable",
            expr = true,
        },
        {
            "<leader>rp",
            function()
                return require("refactoring").debug.print_var({ normal = true })
            end,
            mode = "n",
            desc = "Print var",
        },
        {
            "<leader>rc",
            function()
                return require("refactoring").debug.cleanup({})
            end,
            mode = "n",
            desc = "Cleanup function",
        },
    },
}
