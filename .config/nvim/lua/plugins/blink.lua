return {
    "saghen/blink.cmp",
    version = "v0.*",
    enabled = true,
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
        keymap = {
            preset = "enter",
        },
        snippets = { preset = "luasnip" },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = {
            enabled = true,
        },
        cmdline = {
            enabled = false,
        },
    },
}
