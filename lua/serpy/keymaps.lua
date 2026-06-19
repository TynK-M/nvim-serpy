local M = {}

function M.setup(opts)
	if not opts.keymaps.enabled then
		return
	end

	local map = vim.keymap.set
	local km = opts.keymaps

	-- Python
	map("n", km.pyrun_current, function()
		require("serpy").run("python")
	end, { desc = "serpy(python): run current file" })

	map("n", km.pyrun_current_with_flags, function()
		vim.ui.input({ prompt = "Flags: " }, function(input)
			require("serpy").run("python", input or "")
		end)
	end, { desc = "serpy(python): run current file with flags" })

	map("n", km.pydoc, function()
		vim.ui.input({ prompt = "Docs: " }, function(input)
			require("serpy").docs("python", input or "")
		end)
	end, { desc = "serpy(python): search a term in the pydoc" })

	map("n", km.pydoc_current_word, function()
		local word = vim.fn.expand("<cword>")
		require("serpy").docs("python", word)
	end, { desc = "serpy(python): search current word in the pydoc" })

	-- Lua
	map("n", km.luarun_current, function()
		require("serpy").run("lua")
	end, { desc = "serpy(lua): run current file" })
end

return M
