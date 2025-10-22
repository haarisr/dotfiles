return
-- the colorscheme should be available when starting Neovim
{
    {
        "folke/tokyonight.nvim",
        "sainnhe/sonokai",
        "oxfist/night-owl.nvim",
        "tiagovla/tokyodark.nvim",
        "tanvirtin/monokai.nvim",
        "projekt0n/github-nvim-theme",
        "navarasu/onedark.nvim",
        "rose-pine/neovim",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            require("catppuccin").setup({ auto_integrations = true })
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
        -- priority = 1000, -- make sure to load this before all the other start plugins
        -- config = function()
        --     -- load the colorscheme here
        --     vim.cmd("colorscheme tokyonight-night")
        -- end,
    },
}
