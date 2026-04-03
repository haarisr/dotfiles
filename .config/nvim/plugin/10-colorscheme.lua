vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })

require("catppuccin").setup({
    auto_integrations = false,
    integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        native_lsp = true,
        telescope = true,
        treesitter = true,
    },
})
vim.cmd.colorscheme("catppuccin")
