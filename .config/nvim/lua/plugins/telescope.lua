return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
                lazy = true,
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                lazy = true,
                build = "make",
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                keys = function()
                    local extensions = require("telescope").extensions.file_browser
                    return {
                        {
                            "<leader>pv",
                            extensions.file_browser,
                            "n",
                            desc = "Open [P]roject [V]iew file browser",
                        },
                        {
                            "<leader>pd",
                            "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
                            "n",
                            desc = "Open [P]roject [D]irectory file browser",
                        },
                    }
                end,
            },
        },
        opts = {
            pickers = {
                colorscheme = { enable_preview = true },
            },
        },

        cmd = "Telescope",
        config = function()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
        end,
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                {
                    "<leader>pf",
                    builtin.find_files,
                    desc = "Find [P]roject [F]iles",
                },
                {
                    "<C-p>",
                    builtin.git_files,
                    desc = "[P]roject git files",
                },
                {
                    "<leader>ps",
                    function()
                        builtin.grep_string({ search = vim.fn.input("Grep > ") })
                    end,
                    desc = "[P]roject [S]earch",
                },
                {
                    "<leader>vh",
                    builtin.help_tags,
                    desc = "Help Tags",
                },
                {
                    "<leader>?",
                    builtin.oldfiles,
                    desc = "[?] Find recently opened files",
                },
                {
                    "<leader>sw",
                    builtin.grep_string,
                    desc = "[S]earch current [W]ord",
                },
                {
                    "<leader>sg",
                    builtin.live_grep,
                    desc = "[S]earch by [G]rep",
                },
                {
                    "<leader>.",
                    '<cmd>lua require("telescope.builtin").find_files({cwd = "%:h"})<CR>',
                    desc = "Find [.] files in current directory",
                },
                {
                    "<leader>fb",
                    builtin.buffers,
                    desc = "Find [f]iles in [B]uffer",
                },
            }
        end,
    },
}
