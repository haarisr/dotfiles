vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/folke/lazydev.nvim",
})

require("mason").setup({})
require("lazydev").setup({})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

local lsp_to_server = {
    lua_ls = "lua-language-server",
    pyright = "pyright",
    basedpyright = "basedpyright",
    ty = "ty",
    clangd = "clangd",
    cmake = "cmake-language-server",
    ruff = "ruff",
    bashls = "bash-language-server",
    dockerls = "dockerfile-language-server",
    ["rust-analyzer"] = "rust-analyzer",
    stylua = "stylua",
    copilot = "copilot-language-server",
}

vim.lsp.enable(vim.tbl_keys(lsp_to_server))

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "",
        source = true,
    },
    float = true,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
})

local installed_servers = require("mason-registry").get_installed_package_names()
for _, server in pairs(lsp_to_server) do
    if not vim.tbl_contains(installed_servers, server) then
        vim.cmd("MasonInstall " .. server)
    end
end
