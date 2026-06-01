local M = {}

function M.setup(opts)
	if not opts.keymaps.enabled then
		return
	end

	local map = vim.keymap.set
	local km = opts.keymaps

	map("n", km.pyrun_current, function()
		require("serpy").runPyFile()
	end, { desc = "serpy: run current file" })

	map("n", km.pyrun_current_with_flags, function()
		require("serpy").runPyFileWithFlags()
	end, { desc = "serpy: run current file with flags" })

	map("n", km.pydoc, function()
		require("serpy").pydoc()
	end, { desc = "serpy: search a term in the pydoc" })
end

return M
