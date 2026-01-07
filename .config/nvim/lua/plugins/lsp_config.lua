return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", cmd = "Mason", opts = {} },
        { "saghen/blink.cmp" },
        { "folke/lazydev.nvim", ft = "lua", opts ={}},
    },
    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

        local ensure_installed = {
            "lua-language-server",
            "pyright",
            "basedpyright",
            "ty",
            "clangd",
            "cmake-language-server",
            "ruff",
            "bash-language-server",
            "dockerfile-language-server",
            "rust-analyzer",
        }
        local installed_package_names = require("mason-registry").get_installed_package_names()
        for _, server_name in ipairs(ensure_installed) do
            if not vim.tbl_contains(installed_package_names, server_name) then
                if server_name == "lua-language-server" then
                    server_name = "lua-language-server@3.16.4"
                end
                vim.cmd(":MasonInstall " .. server_name)
            end
        end

        local servers = {}
        for _, pkg in ipairs(require("mason-registry").get_installed_packages()) do
            if pkg.spec.neovim and pkg.spec.neovim.lspconfig then
                table.insert(servers, pkg.spec.neovim.lspconfig)
            end
        end

        for _, server_name in ipairs(servers) do
            local settings = {}
            local root_dir = nil
            if server_name == "ty" then
                settings = {
                    -- ty = {
                    --     disableLanguageServices = true,
                    -- },
                }
            end
            if server_name == "pyright" or server_name == "basedpyright" or server_name == "ty" then
                root_dir = function(bufnr, cb)
                    local root = vim.fs.root(bufnr, { "uv.lock" })
                        or vim.fs.root(bufnr, { "pyproject.toml" })
                        or vim.fs.root(bufnr, { "setup.py" })
                        or vim.fs.root(bufnr, {"requirements.txt"})
                    if root then
                        cb(root)
                    end
                end
                if server_name == "pyright" or server_name == "basedpyright" then
                    settings = {
                        pyright = {
                            disableLanguageServices = true,
                        },
                        basedpyright = {
                            disableLanguageServices = true,
                        },
                    }
                end
            end

            vim.lsp.config(server_name, {
                capabilities = capabilities,
                settings = settings,
                root_dir = root_dir,
            })
            vim.lsp.enable(server_name)
        end

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
