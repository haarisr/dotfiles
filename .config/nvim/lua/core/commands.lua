vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackClean", function()
    local stale = vim.iter(vim.pack.get())
        :filter(function(x)
            return not x.active
        end)
        :map(function(x)
            return x.spec.name
        end)
        :totable()

    if #stale == 0 then
        vim.notify("No inactive plugins to clean", vim.log.levels.INFO)
        return
    end

    vim.pack.del(stale)
end, {})
