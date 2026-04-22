vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buffer = args.buf
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if not lang then
			return
		end
		local available = require("nvim-treesitter.config").get_available()
		if not vim.tbl_contains(available, lang) then
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

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			require("nvim-treesitter").update()
		end
	end,
})

vim.keymap.set({ "x", "o" }, "af", function()
	return require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Select function outer" })

vim.keymap.set({ "x", "o" }, "if", function()
	return require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Select function inner" })

vim.keymap.set({ "x", "o" }, "ac", function()
	return require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Select class outer" })

vim.keymap.set({ "x", "o" }, "ic", function()
	return require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Select class inner" })
