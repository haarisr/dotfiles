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
        local lspconfig = require("lspconfig")
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
            if server_name == "pyright" or server_name == "basedpyright" then
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

            -- lspconfig[server_name].setup({
            --     capabilities = capabilities,
            --     settings = settings,
            -- })
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                settings = settings,
                root_dir = root_dir,
            })
            vim.lsp.enable(server_name)
        end

        -- vim.api.nvim_create_autocmd("FileType", {
        --     -- This handler will fire when the buffer's 'filetype' is "python"
        --     pattern = "python",
        --     callback = function(args)
        --         vim.lsp.config({
        --             name = "ty",
        --             -- cmd = { '/home/haaris/ruff/target/debug/ty', '--current-directory', '.', '--watch', '-vv', 'server' },
        --             cmd = { "/home/haarisr/ruff/target/debug/ty", "server" },
        --             -- Set the "root directory" to the parent directory of the file in the
        --             -- current buffer (`args.buf`) that contains either a "setup.py" or a
        --             -- "pyproject.toml" file. Files that share a root directory will reuse
        --             -- the connection to the same LSP server.
        --             root_dir = vim.fs.root(args.buf, { "setup.py", "pyproject.toml" }),
        --         })
        --         vim.lsp.enable("ty")
        --     end,
        -- })
        vim.lsp.enable("ty")

        -- vim.lsp.inlay_hint.enable()

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
