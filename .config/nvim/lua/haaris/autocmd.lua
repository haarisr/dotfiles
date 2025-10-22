vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end,
    desc = "Mappings for navigation with a terminal",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local buffer = ev.buf
        -- local builtin = require('telescope.builtin')

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Go to Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "Go to Definition" })
        -- vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buffer, desc = 'Go to Definition' })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "Go to Implementation" })
        -- vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, { buffer = buffer, desc = 'Signature Help' })
        vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            { buffer = buffer, desc = "Add Workspace Folder" }
        )
        vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = buffer, desc = "Remove Workspace Folder" }
        )
        vim.keymap.set("n", "<space>wl", function()
            vim.lsp.buf.list_workspace_folders()
        end, { buffer = buffer, desc = "List Workspace Folder" })
        -- vim.keymap.set("n", "<leader>ws", builtin.lsp_document_symbols, { buffer = buffer, desc = 'Workspace Symbol' })
        vim.keymap.set(
            "n",
            "<space>D",
            vim.lsp.buf.type_definition,
            { buffer = buffer, desc = "Go to Type Definition" }
        )
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename Symbol" })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code Action" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer, desc = "Go to References" })
        -- vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buffer, desc = 'Go to References' })
        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({
                bufnr = buffer,
                lsp_fallback = true,
                timeout_ms = 10000,
            })
            -- vim.lsp.buf.format({ async = true })
        end, { buffer = buffer, desc = "Format" })

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold" }, {
                buffer = buffer,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                buffer = buffer,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })
        end
        vim.keymap.set("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { buffer = buffer, desc = "Toggle Inlay Hints" })

        vim.lsp.inline_completion.enable(true)
        vim.keymap.set("i", "<M-;>", function()
            if not vim.lsp.inline_completion.get() then
                return
            end
        end, {
            expr = true,
            replace_keycodes = true,
            desc = "Get the current inline completion",
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("Closewith_q", {}),
    pattern = {
        "PlenaryTestPopup",
        "alpha",
        "dashboard",
        "fugitive",
        "help",
        "lspinfo",
        "man",
        "mason",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("StripTrailingWhitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
