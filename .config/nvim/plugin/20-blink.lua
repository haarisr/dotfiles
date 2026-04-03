vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "blink.cmp" and (kind == "update" or kind == "install") then
            if not ev.data.active then
                vim.cmd.packadd("blink.cmp")
            end
            require("blink.cmp.fuzzy.build").build()
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("v2.*") },
})

require("blink.cmp").setup({
    keymap = { preset = "enter" },
    snippets = { preset = "luasnip" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    signature = { enabled = true },
    cmdline = { enabled = false },
    fuzzy = { implementation = "rust" },
})
