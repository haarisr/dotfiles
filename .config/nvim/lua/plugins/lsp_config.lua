return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", cmd = "Mason", opts = {} },
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "clangd",
                    "cmake",
                    "ruff",
                    "bashls",
                    "dockerls",
                    "rust_analyzer",
                },
                automatic_enable = false,
            },
        },
        { "saghen/blink.cmp" },
    },
    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
        local servers = require("mason-lspconfig").get_installed_servers()
        for _, server_name in ipairs(servers) do
            local settings = {}
            local root_dir = nil
            if server_name == "lua_ls" then
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                }
            end
            if server_name == "ty" then
                settings = {
                    ty = {
                        disableLanguageServices = true,
                    },
                }
            end
            if server_name == "pyright" or server_name == "basedpyright" or server_name == "ty" then
                root_dir = function(bufnr, cb)
                    local root = vim.fs.root(bufnr, { "uv.lock" })
                        or vim.fs.root(bufnr, { "pyproject.toml" })
                        or vim.fs.root(bufnr, { "setup.py" })
                    if root then
                        cb(root)
                    end
                end
            end
            if server_name == "clangd" then
                capabilities.offsetEncoding = { "utf-16" }
            end

            vim.lsp.config(server_name, {
                capabilities = capabilities,
                settings = settings,
                root_dir = root_dir,
            })
            vim.lsp.enable(server_name)
        end

        local severity_levels = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        }

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
            severity_sort = false,
        })
    end,
}
