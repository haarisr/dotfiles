return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
        vim.g.opencode_opts = {
            -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
        }

        -- Required for `opts.auto_reload`.
        vim.o.autoread = true

        -- Recommended/example keymaps.
        vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end, { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<leader>op", function() require("opencode").prompt("@this") end, { desc = "Add to opencode" })
        vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*",
            callback = function(ev)
                if vim.bo[ev.buf].filetype == "opencode_terminal" then
                    vim.keymap.set({ "n", "t" }, "<C-u>", function()
                        require("opencode").command("session.half.page.up")
                    end, { buffer = ev.buf, desc = "opencode half page up" })
                    vim.keymap.set({ "n", "t" }, "<C-d>", function()
                        require("opencode").command("session.half.page.down")
                    end, { buffer = ev.buf, desc = "opencode half page down" })
                end
            end,
        })
    end,
}
