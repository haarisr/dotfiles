return {
    "theprimeagen/harpoon",
    name = "harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
            },
        })
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
            end,
        })
    end,
    keys = function()
        local harpoon = require("harpoon")
        return {
            {
                "<leader>a",
                function()
                    harpoon:list():add()
                end,
                desc = "Harpoon Add Mark File",
            },
            {
                "<C-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Toggle Quick Menu",
            },
            {
                "<leader>1",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon File 1",
            },
            {
                "<leader>2",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon File 2",
            },
            {
                "<leader>3",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon File 3",
            },
            {
                "<leader>4",
                function()
                    harpoon:list():select(4)
                end,
                desc = "Harpoon File 4",
            },
        }
    end,
}
