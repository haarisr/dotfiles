return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufReadPre",
    enabled = false,
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
                accept = "<M-;>",
                accept_word = false,
                accept_line = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
            settings = {
                advanced = {
                    inlineSuggestCount = 100,
                    listCount = 10,
                    length = 100,
                },
            },
        },
    },

    {
        "github/copilot.vim",
        -- cmd = "Copilot",
        enabled = true,
        event = "BufReadPre",
        config = function()
            vim.g.copilot_no_tab_map = true
        end,
        keys = {
            {
                "<M-;>",
                'copilot#Accept("")',
                mode = "i",
                desc = "Accept Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
            {
                "<M-]>",
                "copilot#Next()",
                mode = "i",
                desc = "Next Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
            {
                "<M-[>",
                "copilot#Previous()",
                mode = "i",
                desc = "Previous Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
            {
                "<C-]>",
                "copilot#Dismiss()",
                mode = "i",
                desc = "Dismiss Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
            {
                "<M-l>",
                "copilot#AcceptLine()",
                mode = "i",
                desc = "Accept Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
            {
                "<M-w>",
                "copilot#AcceptWord()",
                mode = "i",
                desc = "Accept Copilot suggestion",
                expr = true,
                replace_keycodes = false,
                silent = true,
            },
        },
    },
}
