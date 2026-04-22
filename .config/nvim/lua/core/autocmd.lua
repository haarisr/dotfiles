vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local buffer = ev.buf

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Go to Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "Go to Definition" })
        vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, { buffer = buffer, desc = "Go to Type Definition" })
        vim.keymap.set("n", "grr", vim.lsp.buf.references, { buffer = buffer, desc = "Go to References" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "Go to Implementation" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename Symbol" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code Action" })
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
        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({
                bufnr = buffer,
                lsp_fallback = true,
                timeout_ms = 10000,
            })
            -- vim.lsp.buf.format({ async = true })
        end, { buffer = buffer, desc = "Format" })

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", buffer) then
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

        if client and client:supports_method("textDocument/inlineCompletion", buffer) then
            vim.lsp.inline_completion.enable(true, { bufnr = buffer })
            vim.keymap.set(
                "i",
                "<M-;>",
                vim.lsp.inline_completion.get,
                { desc = "LSP: accept inline completion", buffer = buffer }
            )
            vim.keymap.set(
                "i",
                "<M-n>",
                vim.lsp.inline_completion.select,
                { desc = "LSP: switch inline completion", buffer = buffer }
            )
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("StripTrailingWhitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
