return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
        "nvim-treesitter/nvim-treesitter-context",
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buffer = args.buf
                local filetype = args.match
                local lang = vim.treesitter.language.get_lang(filetype)
                if not lang then
                    return
                end
                local available_parsers = require("nvim-treesitter.config").get_available()
                if not vim.tbl_contains(available_parsers, lang) then
                    return
                end
                require("nvim-treesitter").install(lang):await(function()
                    if not pcall(vim.treesitter.start, buffer, lang) then
                        return
                    end
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end)
            end,
        })
    end,
    build = function()
        -- local ensure_installed = { "rust", "cpp", "c", "lua", "vim", "python", "vimdoc", "markdown", "markdown_inline" }
        local ensure_installed = { "lua" }
        require("nvim-treesitter").install(ensure_installed)
        require("nvim-treesitter").update()
    end,
    keys = {
        -- { "<c-s>", desc = "Increment selection" },
        -- { "<bs>", desc = "Decrement selection", mode = "x" },
        {
            "af",
            function()
                return require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end,
            desc = "Select function outer",
            mode = { "x", "o" },
        },
        {
            "if",
            function()
                return require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end,
            desc = "Select function inner",
            mode = { "x", "o" },
        },
        {
            "ac",
            function()
                return require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end,
            desc = "Select class outer",
            mode = { "x", "o" },
        },
        {
            "ic",
            function()
                return require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end,
            desc = "Select class inner",
            mode = { "x", "o" },
        },
    },
}
